module Api
  module V1
    class LibraryController < ActionController::Base
      def index
        user = User.find(params[:user_id])

        if user
          render json: LibrarySerializer.new(user.library).serialize, status: :ok
        else
          render json: { error: 'not found' }, status: :not_found
        end
      end
    end
  end
end
