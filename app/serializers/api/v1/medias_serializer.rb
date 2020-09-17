module Api
  module V1
    class MediasSerializer
      attr_reader :movies
      attr_reader :seasons

      def initialize(movies = nil, seasons = nil)
        @movies  = movies&.order(:created_at)
        @seasons = seasons&.order(:created_at)
      end

      def serialize
        return {} if @movies.blank? && @seasons.blank?
        {
          movies:  @movies ? MoviesSerializer.new(@movies).serialize : {},
          seasons: @seasons ? @seasons&.map{ |season| SeasonSerializer.new(season).serialize } : {},
        }
      end
    end
  end
end