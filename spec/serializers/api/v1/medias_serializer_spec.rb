require 'rails_helper'

module Api
  module V1
    RSpec.describe MediasSerializer do
      describe '#serialize' do
        context 'when there is no seasons nor movies' do
          let(:serialized_medias) do
            {
              movies: [],
              seasons: []
            }
          end

          it 'returns empty object' do
            subject = described_class.new()

            expect(subject.serialize).to eq(serialized_medias)
          end
        end

        context 'when there is no movies but there are seasons' do
          let!(:season_1) { create(:season) }
          let!(:season_2) { create(:season) }

          let(:seasons) { Season.all }

          let(:serialized_medias) do
            {
              movies: [],
              seasons: [
                {
                  id: season_1.id,
                  title: season_1.title,
                  plot: season_1.plot,
                  number: season_1.number,
                  created_at: season_1.created_at.strftime('%m/%d/%Y-%H:%M:%S'),
                },
                {
                  id: season_2.id,
                  title: season_2.title,
                  plot: season_2.plot,
                  number: season_2.number,
                  created_at: season_2.created_at.strftime('%m/%d/%Y-%H:%M:%S'),
                },
              ]
            }
          end

          it 'serializes movies and seasons correctly' do
            subject = described_class.new(nil, seasons)
            expect(subject.serialize).to eq(serialized_medias)
          end
        end

        context 'when there is no seasons but there are movies' do
          let!(:movie_1) { create(:movie) }
          let!(:movie_2) { create(:movie) }

          let(:movies) { Movie.all }

          let(:serialized_medias) do
            {
              movies: [
                {
                  id: movie_1.id,
                  title: movie_1.title,
                  plot: movie_1.plot,
                  created_at: movie_1.created_at.strftime('%m/%d/%Y-%H:%M:%S'),
                },
                {
                  id: movie_2.id,
                  title: movie_2.title,
                  plot: movie_2.plot,
                  created_at: movie_2.created_at.strftime('%m/%d/%Y-%H:%M:%S'),
                },
              ],
              seasons: []
            }
          end

          it 'serializes movies and seasons correctly' do
            subject = described_class.new(movies, nil)
            expect(subject.serialize).to eq(serialized_medias)
          end
        end

        context 'when there are both seasons and movies' do
          let!(:season_1) { create(:season) }
          let!(:season_2) { create(:season) }

          let(:seasons) { Season.all }

          let!(:movie_1) { create(:movie) }
          let!(:movie_2) { create(:movie) }

          let(:movies) { Movie.all }

          it 'serializes movies and seasons correctly' do
            subject = described_class.new(movies, seasons)

            expect(subject.serialize).to eq(
              {
                movies: [
                  {
                    id: movie_1.id,
                    title: movie_1.title,
                    plot: movie_1.plot,
                    created_at: movie_1.created_at.strftime('%m/%d/%Y-%H:%M:%S'),
                  },
                  {
                    id: movie_2.id,
                    title: movie_2.title,
                    plot: movie_2.plot,
                    created_at: movie_2.created_at.strftime('%m/%d/%Y-%H:%M:%S'),
                  },
                ],
                seasons: [
                  {
                    id: season_1.id,
                    title: season_1.title,
                    plot: season_1.plot,
                    number: season_1.number,
                    created_at: season_1.created_at.strftime('%m/%d/%Y-%H:%M:%S'),
                  },
                  {
                    id: season_2.id,
                    title: season_2.title,
                    plot: season_2.plot,
                    number: season_2.number,
                    created_at: season_2.created_at.strftime('%m/%d/%Y-%H:%M:%S'),
                  },
                ]
              }
            )
          end
        end
      end
    end
  end
end
