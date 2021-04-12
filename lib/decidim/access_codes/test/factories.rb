# frozen_string_literal: true

require "decidim/core/test/factories"

FactoryBot.define do
  factory :access_code, class: "Decidim::AccessCodes::AccessCode" do
    organization { create :organization }
    user { create :user }
    created_by { create :user }
    email { Faker::Internet.email }
    code { Faker::Number.hexadecimal(digits: 8).unique }
  end
end
