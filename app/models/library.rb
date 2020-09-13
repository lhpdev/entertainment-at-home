class Library < ApplicationRecord
  belongs_to :user
  has_many :purchase_options
end
