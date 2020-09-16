require 'rails_helper'

module Api
  module V1
    RSpec.describe PurchaseSerializer do
      let(:purchase) { create(:movie_purchase_option) }

      it 'serializes movies correctly' do
        subject = described_class.new(purchase)

        expect(subject.serialize).to eq(purchase)
      end
    end
  end
end
