module Api
  module V1
    class SeasonsController < ActionController::Base
      def index
        seasons = Season.all_cached

        render json: {
          status: 200,
          data:   SeasonsSerializer.new(seasons).serialize
        },
        status: 200
      end
    end
  end
end
