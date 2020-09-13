require 'rails_helper'

RSpec.describe PurchaseOption, type: :model do
  describe 'associations' do
    it { is_expected.to have_db_column(:purchaseble_id).of_type(:integer) }
    it { is_expected.to belong_to(:purchaseble) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:price) }
    it { is_expected.to validate_presence_of(:video_quality) }
  end
end
