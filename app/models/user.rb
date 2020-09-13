class User < ApplicationRecord
  after_create :create_library

  has_one :library

  validates :email, presence: true, uniqueness: true

  private

  def create_library
    Library.create(user: self)
  end
end
