class Movie < ApplicationRecord
  include Purchaseble

  validates :title, :plot, presence: true

  def self.all_cached
    Rails.cache.fetch('Movie.all', expires_in: 12.hours) { all.to_a }
  end
end
