# frozen_string_literal: true

source "https://rubygems.org"

ruby RUBY_VERSION

# Inside the development app, the relative require has to be one level up, as
# the Gemfile is copied to the development_app folder (almost) as is.
base_path = ""
base_path = "../" if File.basename(__dir__) == "development_app"
require_relative "#{base_path}lib/decidim/access_codes/version"

DECIDIM_VERSION = Decidim::AccessCodes::DECIDIM_VERSION

gem "decidim", DECIDIM_VERSION
gem "decidim-access_codes", path: "."

gem "bootsnap", "~> 1.4"
gem "puma", ">= 5.0"
gem "uglifier", "~> 4.1"

group :development, :test do
  gem "byebug", "~> 11.0", platform: :mri
  gem "faker"
  gem "rubocop-faker"

  gem "decidim-dev", DECIDIM_VERSION
end

group :development do
  gem "letter_opener_web", "~> 1.3"
  gem "listen", "~> 3.1"
  gem "web-console", "~> 3.5"
end

group :test do
  gem "coveralls_reborn", require: false
end
