class Library < ApplicationRecord
  belongs_to :user
  has_many :contents, foreign_key: 'library_id', class_name: 'PurchaseOption'
end
