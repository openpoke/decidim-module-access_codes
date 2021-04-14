# frozen_string_literal: true

require "securerandom"

module Decidim
  module AccessCodes
    module Verification
      module Admin
        # A form object to be used when admins want to send access codes to a list of emails.
        class AccessCodeForm < AuthorizationHandler
          attribute :emails, String

          validates :emails, presence: true

          alias organization current_organization
        end
      end
    end
  end
end
