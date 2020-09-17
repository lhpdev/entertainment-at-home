require 'rails_helper'

module Api
  module V1
    RSpec.describe MovieSerializer do
      let(:movie) { create(:movie) }

      let(:serialized_movie) do
        {
          id: movie.id,
          title: movie.title,
          plot: movie.plot,
          created_at: movie.created_at.strftime('%m/%d/%Y-%H:%M:%S'),
        }
      end

      it 'serializes movie correctly' do
        subject = described_class.new(movie)
        expect(subject.serialize).to eq(serialized_movie)
      end
    end
  end
end
