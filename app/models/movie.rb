class Movie < ApplicationRecord
  include Purchaseble

  validates :title, :plot, presence: true
end
