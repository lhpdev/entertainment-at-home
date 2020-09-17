require 'rails_helper'

module Api
  module V1
    RSpec.describe SeasonsSerializer do
      describe '#serialize' do
        context 'when there is no season' do
          context 'when there is no seasons nor movies' do
            it 'returns an empty object' do
              subject = described_class.new(nil)
              expect(subject.serialize).to eq({})
            end
          end
        end

        context 'when there are seasons' do
          let!(:season_1) { create(:season) }
          let!(:season_2) { create(:season) }

          let(:seasons) { Season.all }

          let!(:episode_1) { create(:episode, season: season_1, title: "Episode 1 from Season #{season_1.id}", plot: 'Plot', episode_number: 1) }
          let!(:episode_2) { create(:episode, season: season_1, title: "Episode 2 from Season #{season_1.id}", plot: 'Plot', episode_number: 2) }
          let!(:episode_3) { create(:episode, season: season_2, title: "Episode 1 from Season #{season_2.id}", plot: 'Plot', episode_number: 1) }
          let!(:episode_4) { create(:episode, season: season_2, title: "Episode 2 from Season #{season_2.id}", plot: 'Plot', episode_number: 2) }

          let(:serialized_seasons) do
            [
              {
                id: season_1.id,
                title: season_1.title,
                plot: season_1.plot,
                number: season_1.number,
                created_at: season_1.created_at.strftime('%m/%d/%Y-%H:%M:%S'),
                episodes: [
                  {
                    id: episode_1.id,
                    title: episode_1.title,
                    plot: episode_1.plot,
                    episode_number: episode_1.episode_number,
                  },
                  {
                    id: episode_2.id,
                    title: episode_2.title,
                    plot: episode_2.plot,
                    episode_number: episode_2.episode_number,
                  }
                ]
              },
              {
                id: season_2.id,
                title: season_2.title,
                plot: season_2.plot,
                number: season_2.number,
                created_at: season_2.created_at.strftime('%m/%d/%Y-%H:%M:%S'),
                episodes: [
                  {
                    id: episode_3.id,
                    title: episode_3.title,
                    plot: episode_3.plot,
                    episode_number: episode_3.episode_number,
                  },
                  {
                    id: episode_4.id,
                    title: episode_4.title,
                    plot: episode_4.plot,
                    episode_number: episode_4.episode_number,
                  }
                ]
              }
            ]
          end

          it 'serializes movies correctly' do
            subject = described_class.new(seasons)
            expect(subject.serialize).to eq(serialized_seasons)
          end
        end
      end
    end
  end
end
