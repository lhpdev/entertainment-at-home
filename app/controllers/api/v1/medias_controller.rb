module Api
  module V1
    class MediasController < ActionController::Base
      def index
        movies = Movie.all_cached
        season = Season.all_cached

        render json: {
          status: 200,
          data:   MediasSerializer.new(movies, season).serialize
        },
        status: 200
      end
    end
  end
end