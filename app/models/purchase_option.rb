class PurchaseOption < ApplicationRecord
  belongs_to :purchaseble, polymorphic: true

  validates :price, :video_quality, presence: true
end
