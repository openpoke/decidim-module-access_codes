# frozen_string_literal: true

module Decidim
  module AccessCodes
    module Verification
      class ConfirmUserAuthorization < Decidim::Verifications::ConfirmUserAuthorization
        def call
          return broadcast(:invalid) unless form.valid?

          form.access_code.use!

          authorization.grant!
          broadcast(:ok)
        end
      end
    end
  end
end
