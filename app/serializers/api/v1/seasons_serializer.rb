module Api
  module V1
    class SeasonsSerializer
      attr_reader :seasons

      def initialize(seasons)
        @seasons = seasons
      end

      def serialize
        return {} if @seasons.blank?

        result = []

        @seasons.order(:created_at).each do |season|
          result <<
          {
            id: season.id,
            title: season.title,
            plot: season.plot,
            number: season.number,
            created_at: season.created_at,
            updated_at: season.updated_at,
            episodes: season.episodes.order(:episode_number)
          }
        end
        result
      end
    end
  end
end