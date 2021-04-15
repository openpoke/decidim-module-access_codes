# frozen_string_literal: true

module Decidim
  module AccessCodes
    module Verification
      class AuthorizationsController < Decidim::ApplicationController
        include Decidim::Verifications::Renewable

        helper_method :authorization

        before_action :authorization

        def new
          enforce_permission_to :create, :authorization, authorization: authorization

          @form = AuthorizationForm.new(handler_handle: authorization_handle).with_context(current_organization: current_organization)
        end

        def create
          enforce_permission_to :create, :authorization, authorization: authorization

          @form = AuthorizationForm.from_params(
            params.merge(user: current_user)
          ).with_context(current_organization: current_organization)

          Decidim::AccessCodes::Verification::ConfirmUserAuthorization.call(authorization, @form, session) do
            on(:ok) do
              flash[:notice] = t("authorizations.create.success", scope: "decidim.access_codes.verification")
              redirect_to decidim_verifications.authorizations_path
            end

            on(:invalid) do
              flash.now[:alert] = t("authorizations.create.error", scope: "decidim.access_codes.verification")
              render :new
            end
          end
        end

        def edit
          enforce_permission_to :create, :authorization, authorization: authorization
        end

        private

        def authorization
          @authorization ||= Decidim::Authorization.find_or_initialize_by(
            user: current_user,
            name: authorization_handle
          )
        end

        def authorization_handle
          # In case the form is posted, the authorization handle is not
          # available from the request path.
          tmpform = AuthorizationForm.from_params(params)
          return tmpform.handler_name unless tmpform.handler_name.nil?

          # When the new action is called, the authorization handle is the
          # included as a URL parameter.
          return params[:handler] if params[:action] == "new" && params[:handler].present?

          # When the renew action is called, the authorization handle is the
          # first part of the URL.
          return request.path.split("/")[1] if params[:action] == "renew"

          # Determine the handle from the request path
          request.path.split("/").last
        end
      end
    end
  end
end
