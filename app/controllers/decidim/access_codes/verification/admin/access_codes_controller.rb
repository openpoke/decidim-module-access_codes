# frozen_string_literal: true

module Decidim
  module AccessCodes
    module Verification
      module Admin
        class AccessCodesController < Decidim::Admin::ApplicationController
          helper_method :access_codes

          def index
            enforce_permission_to :index, :authorization
          end
          
          def new
            enforce_permission_to :create, :authorization

            @form = AccessCodeForm.new
          end

          private

          def access_codes
            @access_codes ||= AccessCode.where(organization: current_organization).page(params[:page]).per(15)
          end
        end
      end
    end
  end
end
