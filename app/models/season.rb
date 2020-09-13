class Season < ApplicationRecord
  has_many :episodes, foreign_key: :season_id

  validates :title, :plot, presence: true
end
