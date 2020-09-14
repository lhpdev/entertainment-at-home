require 'rails_helper'

module Api
  module V1
    RSpec.describe MoviesSerializer do
      describe '#serialize' do
        let!(:movie_1) { create(:movie) }
        let!(:movie_2) { create(:movie) }

        it 'serializes movies correctly' do
          movies = Movie.all.order(:created_at)
          subject = described_class.new(movies)

          expect(subject.serialize).to eq(movies)
        end
      end
    end
  end
end
