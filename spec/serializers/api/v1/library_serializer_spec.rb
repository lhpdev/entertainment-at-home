require 'rails_helper'

module Api
  module V1
    RSpec.describe LibrarySerializer do
      describe '#serialize' do
        let(:user) { create(:user) }

        context 'when users has no purchases' do
          context 'when there is no seasons nor movies' do
            it 'returns an empty object' do
              subject = described_class.new(user.library)
              expect(subject.serialize).to eq([])
            end
          end
        end

        context 'when user has purchases' do
          let!(:purchase_1) { create(:movie_purchase_option, library: user.library) }
          let!(:purchase_2) { create(:movie_purchase_option, library: user.library) }

          let(:serialized_library) do
            [
              {
                media: {
                  id: purchase_1.purchaseble.id,
                  title: purchase_1.purchaseble.title,
                  plot: purchase_1.purchaseble.plot,
                  created_at: purchase_1.purchaseble.created_at.strftime('%m/%d/%Y-%H:%M:%S'),
                },
                expires_at: purchase_1.expires_at.to_time.strftime('%m/%d/%Y-%H:%M:%S'),
              },
              {
                media: {
                  id: purchase_2.purchaseble.id,
                  title: purchase_2.purchaseble.title,
                  plot: purchase_2.purchaseble.plot,
                  created_at: purchase_2.purchaseble.created_at.strftime('%m/%d/%Y-%H:%M:%S'),
                },
                expires_at: purchase_2.expires_at.to_time.strftime('%m/%d/%Y-%H:%M:%S'),
              },
            ]
          end

          it 'serializes movies correctly' do
            subject = described_class.new(user.library)
            expect(subject.serialize).to eq(serialized_library)
          end
        end

        context 'when user has purchases close to expiration date' do
          let!(:purchase_1) { create(:movie_purchase_option, library: user.library) }
          let!(:purchase_2) { create(:movie_purchase_option, library: user.library) }

          before do
            purchase_2.update(expires_at: DateTime.current + 1.day)
          end

          let(:serialized_library) do
            [
              {
                media: {
                  id: purchase_2.purchaseble.id,
                  title: purchase_2.purchaseble.title,
                  plot: purchase_2.purchaseble.plot,
                  created_at: purchase_2.purchaseble.created_at.strftime('%m/%d/%Y-%H:%M:%S'),
                },
                expires_at: purchase_2.expires_at.to_time.strftime('%m/%d/%Y-%H:%M:%S'),
              },
              {
                media: {
                  id: purchase_1.purchaseble.id,
                  title: purchase_1.purchaseble.title,
                  plot: purchase_1.purchaseble.plot,
                  created_at: purchase_1.purchaseble.created_at.strftime('%m/%d/%Y-%H:%M:%S'),
                },
                expires_at: purchase_1.expires_at.to_time.strftime('%m/%d/%Y-%H:%M:%S'),
              },
            ]
          end

          it 'should order the purchases by expires_at' do
            subject = described_class.new(user.library)
            expect(subject.serialize).to eq(serialized_library)
          end
        end
      end
    end
  end
end
