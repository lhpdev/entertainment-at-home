
require 'rails_helper'

module Api
  module V1
    RSpec.describe PurchasesController, type: :controller do
      describe 'POST create' do
        let(:user){ create(:user) }
        let(:movie){ create(:movie) }

        subject {
          post :create,
          params: {
            user_id: user.id,
            purchase: { purchaseble_id: movie.id, purchaseble_type: movie.class, video_quality: 'HD'}
          }
        }

        context 'when creates a purchase succesfully' do
          it 'returns ok status' do
            subject
            expect(response.status).to eq(201)
          end

          it 'returns serialized purchase' do
            subject
            expect(JSON.parse(response.body)).to eq({
              'status'=>201,
              'success'=>true,
              'data'=>{
                'id'=>1,
                'library_id'=>1,
                'price'=>2.99,
                'video_quality'=>'HD',
                'expires_at'=>"#{PurchaseOption.last.expires_at.to_time.strftime('%m/%d/%Y-%H:%M:%S')}",
                'purchased'=>{
                  'id'=>movie.id,
                  'title'=>"#{movie.title}",
                  'plot'=>"#{movie.plot}",
                  'created_at'=>"#{movie.created_at.strftime('%m/%d/%Y-%H:%M:%S')}"
                }
              }
            })
          end
        end

        context 'when does not create a purchase' do
          context 'when purchased media is still live in user libray' do
            before do
              create(:movie_purchase_option, library: user.library, purchaseble: movie)
            end

            it 'returns status not_found with correct error' do
              subject

              expect(response.status).to eq(400)
              expect(JSON.parse(response.body)).to eq({
                'status' => 400,
                'success' => false,
                'error' => "operation not allowed because there is an alive Movie with id: 1 in the library"
              })
            end
          end

          context 'when user not found' do
            subject {
              post :create,
              params: {
                user_id: 32,
                purchase: { purchaseble_id: movie.id, purchaseble_type: movie.class, video_quality: 'HD'}
              }
            }

            it 'returns status not_found with correct error' do
              subject

              expect(response.status).to eq(404)
              expect(JSON.parse(response.body)).to eq({
                'status' => 404,
                'success' => false,
                'error' => "user not found with id: 32"
              })
            end
          end

          context 'when content not found' do
            subject {
              post :create,
              params: {
                user_id: user.id,
                purchase: { purchaseble_id: 55, purchaseble_type: movie.class, video_quality: 'HD'}
              }
            }

            it 'returns status not_found with correct error' do
              subject

              expect(response.status).to eq(404)
              expect(JSON.parse(response.body)).to eq({
                'status' => 404,
                'success' => false,
                'error' => "Movie not found with id: 55"
              })
            end
          end
        end
      end
    end
  end
end