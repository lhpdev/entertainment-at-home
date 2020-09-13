class Episode < ApplicationRecord
  belongs_to :season

  validates :title, :plot, :episode_number, presence: true
end
