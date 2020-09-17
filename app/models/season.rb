class Season < ApplicationRecord
  include Purchaseble

  has_many :episodes, foreign_key: :season_id

  validates :title, :plot, presence: true

  def cached_episodes
    Rails.cache.fetch("Season/#{id}/Episodes.all", expires_in: 12.hours) { episodes.to_a }
  end

  def self.all_cached
    Rails.cache.fetch('Season.all', expires_in: 12.hours) { all.includes(:episodes).to_a }
  end
end
