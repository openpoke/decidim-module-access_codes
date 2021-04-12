# frozen_string_literal: true

module Decidim
  module AccessCodes
    module Verification
      class ConfirmUserAuthorization < Decidim::Verifications::ConfirmUserAuthorization
        def call
          return broadcast(:invalid) unless form.valid?

          authorization.grant!
          form.access_code.use!
          broadcast(:ok)
        end
      end
    end
  end
end
