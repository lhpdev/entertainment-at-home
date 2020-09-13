module Api
  module V1
    class MoviesController < ActionController::Base
      def index
        movies = Movie.all

        if movies
          render json: MoviesSerializer.new(movies).serialize, status: :ok
        else
          render json: { error: 'not found' }, status: :not_found
        end
      end
    end
  end
end
