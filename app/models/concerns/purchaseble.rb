module Purchaseble
  extend ActiveSupport::Concern

  included do
    has_many :purchase_options, as: :purchaseble
  end
end