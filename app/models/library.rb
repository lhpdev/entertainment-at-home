class Library < ApplicationRecord
  belongs_to :user

  has_many :contents, foreign_key: 'library_id', class_name: 'PurchaseOption'

  def cached_contents
    Rails.cache.fetch("User/#{user_id}/Library/Contents", expires_in: 12.hours) { contents.alive.includes(:purchaseble).to_a }
  end
end