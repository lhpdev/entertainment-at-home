require 'rails_helper'

module Api
  module V1
    RSpec.describe EpisodeSerializer do
      let(:episode) { create(:episode) }

      let(:serialized_episode) do
        {
          id: episode.id,
          title: episode.title,
          plot: episode.plot,
          episode_number: episode.episode_number,
        }
      end

      it 'serializes episode correctly' do
        subject = described_class.new(episode)

        expect(subject.serialize).to eq(serialized_episode)
      end
    end
  end
end
