module Api
  module V1
    class MovieSerializer
      attr_reader :movie

      def initialize(movie)
        @movie = movie
      end

      def serialize
        return {} if @movie.blank?

        {
           id: @movie.id,
           title: @movie.title,
           plot: @movie.plot,
           created_at: @movie.created_at.strftime('%m/%d/%Y-%H:%M:%S'),
        }
      end
    end
  end
end