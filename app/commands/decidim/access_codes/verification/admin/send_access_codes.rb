# frozen_string_literal: true

module Decidim
  module AccessCodes
    module Verification
      module Admin
        # ...
        class SendAccessCode < Rectify::Command
          # Public: Initializes the command.
          #
          # authorization - An Authorization to be confirmed.
          # form - A form object with the emails to send access codes to.
          def initialize(authorization, form)
            @authorization = authorization
            @form = form
          end

          # Executes the command. Broadcasts these events:
          #
          # - :ok when everything is valid.
          # - :invalid if the form wasn't valid and we couldn't proceed.
          #
          # Returns nothing.
          def call
            return broadcast(:invalid) if @form.invalid?

            @access_code = Decidim::AccessCodes::AccessCode.create!(
              organization: @form.user.organization,
              email: @form.email
            )

            Decidim::AccessCodes::AccessCodeMailer.send_code(@access_code).deliver_later

            broadcast(:ok)
          end

          private

          attr_reader :authorization, :form
        end
      end
    end
  end
end
