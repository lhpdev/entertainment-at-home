module Api
  module V1
    class SeasonsController < ActionController::Base
      def index
        season = Season.all.includes(:episodes)

        render json: { status: 200, data: SeasonsSerializer.new(season).serialize }, status: 200
      end
    end
  end
end
