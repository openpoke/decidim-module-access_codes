# frozen_string_literal: true

require "securerandom"

module Decidim
  module AccessCodes
    module Admin
      # A form object to be used when admins want to send access codes to an email.
      class AccessCodeForm < AuthorizationHandler
        attribute :email, String

        validates :email, presence: true
      end
    end
  end
end
