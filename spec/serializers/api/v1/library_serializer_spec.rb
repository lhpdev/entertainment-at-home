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

              expect(subject.serialize).to eq({})
            end
          end
        end

        context 'when user has purchases' do
          let(:movie_1) { create(:movie) }
          let(:movie_2) { create(:movie) }
          let!(:purchase_1) { create(:movie_purchase_option, library: user.library, purchaseble: movie_1, video_quality: :HD) }
          let!(:purchase_2) { create(:movie_purchase_option, library: user.library, purchaseble: movie_2, video_quality: :HD) }

          it 'serializes movies correctly' do
            subject = described_class.new(user.library)

            expect(subject.serialize).to eq([purchase_1, purchase_2])
          end
        end

        context 'when user has purchases close to expiration date' do
          let(:movie_1) { create(:movie) }
          let(:movie_2) { create(:movie) }

          let!(:purchase_1) { create(:movie_purchase_option, library: user.library, purchaseble: movie_1, video_quality: :HD) }
          let!(:purchase_2) { create(:movie_purchase_option, library: user.library, purchaseble: movie_2, video_quality: :HD) }

          before do
            purchase_2.update(expires_at: DateTime.current + 1.day)
          end

          it 'should order the purchases by expires_at' do
            subject = described_class.new(user.library)

            expect(subject.serialize).to eq([purchase_2, purchase_1])
          end
        end
      end
    end
  end
end
