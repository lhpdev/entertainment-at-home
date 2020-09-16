
require 'rails_helper'

module Api
  module V1
    RSpec.describe PurchasesController, type: :controller do
      describe 'POST create' do
        let(:user){ create(:user) }
        let(:movie){ create(:movie) }

        subject {
          post :create, params: {
                            user_id: user.id,
                            purchase: { purchaseble_id: movie.id, purchaseble_type: movie.class, video_quality: 'HD'
                          }
                        }
        }

        context 'when creates a purchase succesfully' do
          it 'returns ok status' do
            subject

            expect(response.status).to eq(200)
          end

          it 'returns serialized purchase' do
            subject

            expect(response.body).to eq PurchaseSerializer.new(PurchaseOption.last).serialize.to_json
          end
        end

        context 'when does not create a purchase' do
          before do
            create(:movie_purchase_option, library: user.library, purchaseble: movie)
          end

          it 'returns status not_found' do
            subject

            expect(response.status).to eq(404)
            expect(JSON.parse(response.body)).to eq({"error"=>["operation not allowed because there is an alive Movie with id: 1 in the library"]})
          end
        end
      end
    end
  end
end