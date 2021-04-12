# frozen_string_literal: true

require "securerandom"

module Decidim
  module AccessCodes
    module Admin
      # A form object for users to enter their access code to get verified.
      class AuthorizationForm < AuthorizationHandler
        attribute :code, String

        validate :valid_code?

        private

        def valid_code?
          errors.add(:code, :invalid) unless access_code.usable?
        end
        
        def access_code
          Decidim::AccessCodes::AccessCode.find_by(organization: organization, code: code)
        end
      end
    end
  end
end
