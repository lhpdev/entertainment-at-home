module Api
  module V1
    class MoviesController < ActionController::Base
      def index
        movies = Movie.all_cached

        render json: {
          status: 200,
          data:   MoviesSerializer.new(movies).serialize
        },
        status: 200
      end
    end
  end
end
