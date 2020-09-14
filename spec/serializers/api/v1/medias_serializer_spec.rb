require 'rails_helper'

module Api
  module V1
    RSpec.describe MediasSerializer do
      describe '#serialize' do
        context 'when there is no seasons nor movies' do
          it 'serializes movies and seasons correctly' do
            seasons = Season.all
            movies  = Movie.all

            subject = described_class.new(movies, seasons)

            expect(subject.serialize).to eq({})
          end
        end

        context 'when there is no movies but there are seasons' do
          let!(:season_1) { create(:season) }
          let!(:season_2) { create(:season) }

          before do
            season_1.episodes.create!(title: "Episode 1 from Season #{season_1.id}", plot: 'Plot', episode_number: 1)
            season_1.episodes.create!(title: "Episode 2 from Season #{season_1.id}", plot: 'Plot', episode_number: 2)
            season_2.episodes.create!(title: "Episode 1 from Season #{season_2.id}", plot: 'Plot', episode_number: 1)
            season_2.episodes.create!(title: "Episode 2 from Season #{season_2.id}", plot: 'Plot', episode_number: 2)
          end

          it 'serializes movies and seasons correctly' do
            seasons = Season.all
            movies  = Movie.all

            subject = described_class.new(movies, seasons)

            expect(subject.serialize).to eq(
              {
                movies:  {},
                seasons: SeasonsSerializer.new(seasons).serialize
              }
            )
          end
        end

        context 'when there is no seasons but there are movies' do
          let!(:movie_1) { create(:movie) }
          let!(:movie_2) { create(:movie) }

          it 'serializes movies and seasons correctly' do
            seasons = Season.all
            movies  = Movie.all

            subject = described_class.new(movies, seasons)

            expect(subject.serialize).to eq(
              {
                movies:  MoviesSerializer.new(movies).serialize,
                seasons: {}
              }
            )
          end
        end

        context 'when there are both seasons and movies' do
          let!(:season_1) { create(:season) }
          let!(:season_2) { create(:season) }

          let!(:movie_1) { create(:movie) }
          let!(:movie_2) { create(:movie) }

          before do
            season_1.episodes.create!(title: "Episode 1 from Season #{season_1.id}", plot: 'Plot', episode_number: 1)
            season_1.episodes.create!(title: "Episode 2 from Season #{season_1.id}", plot: 'Plot', episode_number: 2)
            season_2.episodes.create!(title: "Episode 1 from Season #{season_2.id}", plot: 'Plot', episode_number: 1)
            season_2.episodes.create!(title: "Episode 2 from Season #{season_2.id}", plot: 'Plot', episode_number: 2)
          end

          it 'serializes movies and seasons correctly' do
            seasons = Season.all
            movies  = Movie.all

            subject = described_class.new(movies, seasons)

            expect(subject.serialize).to eq(
              {
                movies:  MoviesSerializer.new(movies).serialize,
                seasons: SeasonsSerializer.new(seasons).serialize
              }
            )
          end
        end
      end
    end
  end
end
