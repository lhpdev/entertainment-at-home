module Api
  module V1
    class LibraryController < ActionController::Base
      def index
        user = User.find_by(id: params[:user_id])

        if user
          render json: { status: 200, data: LibrarySerializer.new(user.library).serialize }, status: 200
        else
          render json: { status: 404, error_message: "Library not found for user with id: '#{params[:user_id]}'" }, status: 404
        end
      end
    end
  end
end
