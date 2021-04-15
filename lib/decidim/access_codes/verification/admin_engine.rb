# frozen_string_literal: true

module Decidim
  module AccessCodes
    module Verification
      # This is an engine that implements the administration interface for
      # user authorization by access request.
      class AdminEngine < ::Rails::Engine
        isolate_namespace Decidim::AccessCodes::Verification::Admin
        paths["db/migrate"] = nil

        routes do
          resources :access_codes, only: [:index, :show, :new, :create, :destroy]
          resources :authorizations, only: [:destroy]

          root to: "access_codes#index"
        end
      end
    end
  end
end
