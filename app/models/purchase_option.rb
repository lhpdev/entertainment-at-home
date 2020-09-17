class PurchaseOption < ApplicationRecord
  after_create :set_expiration_date, :expire_user_library_cache

  belongs_to :purchaseble, polymorphic: true
  belongs_to :library

  validates :price, :video_quality, presence: true

  scope :alive, -> { where("purchase_options.expires_at >= ?", DateTime.current) }

  enum video_quality: { HD: 0, SD: 1 }

  private

  def set_expiration_date
    self.expires_at = DateTime.current + 2.days
    self.save
  end

  def expire_user_library_cache
    Rails.cache.delete("User/#{library.user_id}/Library/Contents")
  end
end
