module Api
  module V1
    class MediasController < ActionController::Base
      def index
        movies = Movie.all
        season = Season.all.includes(:episodes)

        if movies || season
          render json: MediasSerializer.new(movies, season).serialize, status: :ok
        else
          render json: { error: 'not found' }, status: :not_found
        end
      end
    end
  end
end
