module Api
  module V1
    class MoviesSerializer
      attr_reader :movies

      def initialize(movies)
        @movies = movies
      end

      def serialize
        return [] if @movies.blank?

        result = @movies.map do |movie|
          MovieSerializer.new(movie).serialize
        end

        result.sort_by{ |movie| movie[:created_at] }
      end
    end
  end
end