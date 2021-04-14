# frozen_string_literal: true

module Decidim
  module AccessCodes
    module Verification
      module Admin
        class AccessCodesController < Decidim::Admin::ApplicationController
          helper_method :access_code, :access_codes, :users

          def index
            enforce_permission_to :index, :authorization
          end

          def show
            enforce_permission_to :read, :authorization
          end

          def new
            enforce_permission_to :create, :authorization

            @form = AccessCodeForm.new
          end

          def create
            enforce_permission_to :create, :authorization

            @form = AccessCodeForm.from_params(params).with_context(current_organization: current_organization)

            Decidim::AccessCodes::Verification::Admin::SendAccessCodes.call(@form) do
              on(:ok) do
                flash[:notice] = t("access_codes.create.success", scope: "decidim.access_codes.verification.admin")
                redirect_to access_codes_path
              end

              on(:invalid) do
                flash.now[:alert] = t("access_codes.create.error", scope: "decidim.access_codes.verification.admin")
                render :new
              end
            end
          end

          private

          def access_code
            @access_code ||= AccessCode.find(params[:id])
          end

          def access_codes
            @access_codes ||= AccessCode.where(organization: current_organization).page(params[:page]).per(15)
          end

          def users
            user_ids = Decidim::Authorization.where(name: "access_codes")
                                             .where("verification_metadata->>'access_code_id' = '?'", access_code.id)
                                             .pluck(:decidim_user_id)

            @users ||= Decidim::User.where(organization: current_organization, id: user_ids)
          end
        end
      end
    end
  end
end
