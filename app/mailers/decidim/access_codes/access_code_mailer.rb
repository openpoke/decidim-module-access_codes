# frozen_string_literal: true

module Decidim
  module AccessCodes
    # This mailer sends an email with an access code for user verification
    class AccessCodeMailer < Decidim::ApplicationMailer
      # Public: Sends a notification email with an access code for user verification
      #
      # access_code - The access code object containing the email and the code itself
      #
      # Returns nothing.
      def send_code(access_code)
        @organization = @access_code.organization
        @access_code = access_code

        mail(to: @access_code.email, subject: I18n.t("decidim.access_codes.access_codes_mailer.send_code.subject"))
      end
    end
  end
end
