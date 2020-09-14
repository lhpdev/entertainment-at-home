module Api
  module V1
    class MediasSerializer
      attr_reader :movies
      attr_reader :seasons

      def initialize(movies = nil, seasons = nil)
        @movies  = movies
        @seasons = seasons
      end

      def serialize
        return {} if @movies.blank? && @seasons.blank?

        result = {
          movies:  MoviesSerializer.new(@movies).serialize,
          seasons: SeasonsSerializer.new(@seasons).serialize
        }
      end
    end
  end
end