require 'rails_helper'

module Api
  module V1
    RSpec.describe SeasonsSerializer do
      describe '#serialize' do
        context 'when there is no season' do
          context 'when there is no seasons nor movies' do
            it 'returns an empty object' do
              movies  = Movie.all

              subject = described_class.new(movies)

              expect(subject.serialize).to eq({})
            end
          end
        end

        context 'when there are seasons' do
          let!(:season_1) { create(:season) }
          let!(:season_2) { create(:season) }

          before do
            season_1.episodes.create!(title: "Episode 1 from Season #{season_1.id}", plot: 'Plot', episode_number: 1)
            season_1.episodes.create!(title: "Episode 2 from Season #{season_1.id}", plot: 'Plot', episode_number: 2)
            season_2.episodes.create!(title: "Episode 1 from Season #{season_2.id}", plot: 'Plot', episode_number: 1)
            season_2.episodes.create!(title: "Episode 2 from Season #{season_2.id}", plot: 'Plot', episode_number: 2)
          end

          it 'serializes movies correctly' do
            seasons = Season.all
            subject = described_class.new(seasons)

            expect(subject.serialize).to eq([
              {
                id: season_1.id,
                title: season_1.title,
                plot: season_1.plot,
                number: season_1.number,
                created_at: season_1.created_at,
                updated_at: season_1.updated_at,
                episodes: season_1.episodes.order(:episode_number)
              },
              {
                id: season_2.id,
                title: season_2.title,
                plot: season_2.plot,
                number: season_2.number,
                created_at: season_2.created_at,
                updated_at: season_2.updated_at,
                episodes: season_2.episodes.order(:episode_number)
              }
            ])
          end
        end
      end
    end
  end
end
