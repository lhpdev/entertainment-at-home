class Season < ApplicationRecord
  has_many :episodes, foreign_key: :season_id
end
