module Api
  module V1
    class SeasonsController < ActionController::Base
      def index
        season = Season.all.includes(:episodes)

        if season
          render json: SeasonsSerializer.new(season).serialize, status: :ok
        else
          render json: { error: 'not found' }, status: :not_found
        end
      end
    end
  end
end
