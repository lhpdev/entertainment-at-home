class User < ApplicationRecord
  has_one :library

  validates :email, presence: true, uniqueness: true
end
