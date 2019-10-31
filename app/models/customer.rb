class Customer < ApplicationRecord
  scope :active, -> { where(blacklist: false) }
  scope :blacklisted, -> { where(blacklist: true) }
end
