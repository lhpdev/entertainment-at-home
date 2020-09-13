class PurchaseOption < ApplicationRecord
  belongs_to :purchaseble, polymorphic: true
  belongs_to :library

  validates :price, :video_quality, presence: true

  scope :alive, -> { where("purchase_options.expires_at >= ?", DateTime.today) }
end
