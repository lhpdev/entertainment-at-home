module Api
  module V1
    class MediasController < ActionController::Base
      def index
        movies = Movie.all
        season = Season.all.includes(:episodes)

        render json: { status: 200, data: MediasSerializer.new(movies, season).serialize }, status: 200
      end
    end
  end
end
