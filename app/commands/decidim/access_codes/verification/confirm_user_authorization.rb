# frozen_string_literal: true

module Decidim
  module AccessCodes
    module Verification
      class ConfirmUserAuthorization < Decidim::Verifications::ConfirmUserAuthorization
        def call
          return broadcast(:invalid) unless form.valid?

          access_code = form.access_code

          access_code.use!

          authorization.update(metadata: {
                                 "access_code_id" => access_code.id,
                                 "code" => access_code.code,
                                 "name" => access_code.name,
                                 "email" => access_code.email
                               })

          authorization.grant!

          broadcast(:ok)
        end
      end
    end
  end
end
