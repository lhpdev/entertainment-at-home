module Api
  module V1
    class MoviesSerializer
      attr_reader :movies

      def initialize(movies)
        @movies = movies&.order(:created_at)
      end

      def serialize
        return {} if @movies.blank?

        @movies.map do |movie|
          MovieSerializer.new(movie).serialize
        end
      end
    end
  end
end