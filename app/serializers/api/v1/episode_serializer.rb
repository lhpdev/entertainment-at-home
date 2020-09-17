module Api
  module V1
    class EpisodeSerializer
      attr_reader :episode

      def initialize(episode)
        @episode = episode
      end

      def serialize
        return {} if @episode.blank?

        {
          id: @episode.id,
          title: @episode.title,
          plot: @episode.plot,
          episode_number: @episode.episode_number,
        }
      end
    end
  end
end