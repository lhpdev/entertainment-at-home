require 'rails_helper'

module Api
  module V1
    RSpec.describe MoviesSerializer do
      describe '#serialize' do
        context 'when there is no movie' do
          context 'when there is no seasons nor movies' do
            it 'returns an empty object' do
              subject = described_class.new(nil)
              expect(subject.serialize).to eq({})
            end
          end
        end

        context 'when there are movies' do
          let!(:movie_1) { create(:movie) }
          let!(:movie_2) { create(:movie) }

          let(:movies) { Movie.all }

          let(:serialized_movies) do
            [
              {
                id: movie_1.id,
                title: movie_1.title,
                plot: movie_1.plot,
                created_at: movie_1.created_at.strftime('%m/%d/%Y-%H:%M:%S')
              },
              {
                id: movie_2.id,
                title: movie_2.title,
                plot: movie_2.plot,
                created_at: movie_2.created_at.strftime('%m/%d/%Y-%H:%M:%S')
              }
            ]
          end

          it 'serializes movies correctly' do
            subject = described_class.new(movies)
            expect(subject.serialize).to eq(serialized_movies)
          end
        end
      end
    end
  end
end
