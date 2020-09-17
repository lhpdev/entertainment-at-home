module Api
  module V1
    class SeasonsSerializer
      attr_reader :seasons

      def initialize(seasons)
        @seasons = seasons&.order(:created_at)
      end

      def serialize
        return {} if @seasons.blank?

        @seasons.map do |season|
          SeasonSerializer.new(season).serialize
          .merge(
            {
              episodes: season.episodes.order(:episode_number).map do |episode|
                EpisodeSerializer.new(episode).serialize
              end,
            }
          )
        end
      end
    end
  end
end