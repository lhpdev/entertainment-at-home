require 'rails_helper'

module Api
  module V1
    RSpec.describe PurchaseSerializer do
      let(:purchase) { create(:movie_purchase_option) }

      let(:serialized_purchase) do
        {
          id: purchase.id,
          library_id: purchase.library_id,
          price: purchase.price,
          video_quality: purchase.video_quality,
          expires_at: purchase.expires_at.to_time.strftime('%m/%d/%Y-%H:%M:%S'),
          purchased: {
            id: purchase.purchaseble.id,
            title: purchase.purchaseble.title,
            plot: purchase.purchaseble.plot,
            created_at: purchase.purchaseble.created_at.strftime('%m/%d/%Y-%H:%M:%S'),
          }
        }
      end

      it 'serializes movies correctly' do
        subject = described_class.new(purchase)
        expect(subject.serialize).to eq(serialized_purchase)
      end
    end
  end
end
