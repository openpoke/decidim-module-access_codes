# frozen_string_literal: true

module Decidim
  module AccessCodes
    class AccessCode < ApplicationRecord
      class AccessCodeError < StandardError; end
      self.table_name = :decidim_access_codes_access_codes

      belongs_to :organization, foreign_key: "decidim_organization_id", class_name: "Decidim::Organization"

      after_create :generate, :set_maximum_uses

      validates :organization, presence: true
      validates :email, presence: true, 'valid_email_2/email': { disposable: true }
      validates :code, presence: true, uniqueness: { scope: :decidim_organization_id }

      def use!
        return raise AccessCodeError, "Code used too many times" unless usable?

        increment(:times_used)
        save!
      end

      def usable?
        return true unless maximum_uses.positive?

        times_used < maximum_uses
      end

      private

      def generate
        return if code.present?

        loop do
          self.code = Decidim::Tokenizer.new(length: 8).hex_digest("#{email}-#{organization.id}-#{created_at.to_i}")
          if AccessCode.find_by(code: code).blank?
            save!
            break
          end
        end
      end

      def set_maximum_uses
        return if maximum_uses.present?

        update(maximum_uses: Decidim::AccessCodes.config.default_maximum_use_count)
      end
    end
  end
end
