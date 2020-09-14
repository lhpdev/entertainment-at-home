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

  describe 'callbacks' do
    context 'after_create' do
      let!(:user)  { create(:user) }
      let!(:movie) { create(:movie) }

      subject { PurchaseOption.new(library: user.library, purchaseble: movie, price: 10.00, video_quality: :HD) }

      it 'sets the expiration date after create' do
        expect {
          subject.save
        }.to change{ subject.expires_at }
        expect(subject.expires_at).to_not be_nil
      end
    end
  end
end
