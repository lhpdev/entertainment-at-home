module Api
  module V1
    class MoviesSerializer
      attr_reader :movies

      def initialize(movies)
        @movies = movies
      end

      def serialize
        return {} if @movies.blank?

        @movies.order(:created_at)
      end
    end
  end
end