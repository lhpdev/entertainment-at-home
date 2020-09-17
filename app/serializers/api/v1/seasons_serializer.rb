module Api
  module V1
    class SeasonsSerializer
      attr_reader :seasons

      def initialize(seasons)
        @seasons = seasons
      end

      def serialize
        return [] if @seasons.blank?

        result = @seasons.map do |season|
          SeasonSerializer.new(season).serialize
          .merge(
            {
              episodes: season.cached_episodes.sort_by{ |episode| episode.episode_number }.map do |episode|
                EpisodeSerializer.new(episode).serialize
              end,
            }
          )
        end

        result.sort_by{ |season| season[:created_at] }
      end
    end
  end
end