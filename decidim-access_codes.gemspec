# frozen_string_literal: true

lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "decidim/access_codes/version"

Gem::Specification.new do |spec|
  spec.name = "decidim-access_codes"
  spec.version = Decidim::AccessCodes::VERSION
  spec.authors = ["Vera Rojman"]
  spec.email = ["vera@platoniq.net"]

  spec.summary = "Allows admins to send access codes for user authorizations."
  spec.description = "Access codes allow to verify users not yet registered on the platform."
  spec.homepage = "https://github.com/Platoniq/decidim-module-access_codes"
  spec.license = "AGPL-3.0"

  spec.files = Dir[
    "{app,config,db,lib}/**/*",
    "LICENSE-AGPLv3.txt",
    "Rakefile",
    "README.md"
  ]

  spec.require_paths = ["lib"]

  spec.add_dependency "decidim-admin", Decidim::AccessCodes::DECIDIM_VERSION
  spec.add_dependency "decidim-core", Decidim::AccessCodes::DECIDIM_VERSION
  spec.add_dependency "decidim-verifications", Decidim::AccessCodes::DECIDIM_VERSION

  spec.add_development_dependency "decidim-dev", Decidim::AccessCodes::DECIDIM_VERSION
end
