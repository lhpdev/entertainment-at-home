require 'rails_helper'

module Api
  module V1
    RSpec.describe SeasonSerializer do
      let(:season) { create(:season) }

      let(:serialized_season) do
        {
          id: season.id,
          title: season.title,
          plot: season.plot,
          number: season.number,
          created_at: season.created_at.strftime('%m/%d/%Y-%H:%M:%S'),
        }
      end

      it 'serializes season correctly' do
        subject = described_class.new(season)
        expect(subject.serialize).to eq(serialized_season)
      end
    end
  end
end
