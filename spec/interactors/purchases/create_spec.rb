require 'rails_helper'

module Purchases
  RSpec.describe Create do
    describe '.call' do
      let!(:user) { create(:user) }
      let!(:movie) { create(:movie) }
      let(:params) do
        {
          user_id: user.id,
          purchaseble_id: movie.id,
          purchaseble_type: movie.class.to_s,
          video_quality: :HD
        }
      end

      subject { described_class.call(params: params) }

      context 'when user is not found' do
        let(:params) do
          {
            user_id: 22,
            purchaseble_id: movie.id,
            purchaseble_type: movie.class.to_s,
            video_quality: :HD
          }
        end

        it 'fails' do
          expect(subject).to be_a_failure
          expect(subject.errors).to eq({ message: 'user not found with id: 22', status: 404 })
        end
      end

      context 'when content is not found' do
        let(:params) do
          {
            user_id: user.id,
            purchaseble_id: 22,
            purchaseble_type: 'Movie',
            video_quality: :HD
          }
        end

        it 'fails' do
          expect(subject).to be_a_failure
          expect(subject.errors).to eq({ message: 'Movie not found with id: 22', status: 404 })
        end
      end

      context 'when content is alive and already included on users library' do
        it 'fails' do
          user.library.contents.create(purchaseble_id: movie.id, purchaseble_type: movie.class, video_quality: :HD)

          expect(subject).to be_a_failure
          expect(subject.errors).to eq({ message: "operation not allowed because there is an alive #{movie.class} with id: #{movie.id} in the library", status: 400 })
        end
      end

      context 'when success' do
        it 'succeeds' do
          expect(subject).to be_a_success
        end
      end
    end
  end
end