module Api
  module V1
    class PurchasesController < ActionController::Base
      skip_before_action :verify_authenticity_token

      def create
        @user = User.find(params[:user_id])

        set_content

        if @user && @content
          if purchaseble?
            @purchase = PurchaseOption.create!(library: @user.library,
                                  purchaseble_id: permitted_params[:purchaseble_id],
                                  purchaseble_type: permitted_params[:purchaseble_type],
                                  video_quality: permitted_params[:video_quality].to_sym)
            if @purchase
              render json: PurchaseSerializer.new(@purchase).serialize, status: :ok
            else
              render json: { error: 'not found' }, status: :not_found
            end
          else
            render json: { error: 'not found' }, status: :not_found
          end
        else
          render json: { error: 'not found' }, status: :not_found
        end
      end

      private

      def permitted_params
        params.require(:purchase).permit(:purchaseble_id, :purchaseble_type, :video_quality)
      end

      def set_content
        if permitted_params[:purchaseble_type] == 'Movie'
          @content = Movie.find(permitted_params[:purchaseble_id])
        else
          @content = Season.find(permitted_params[:purchaseble_id])
        end
      end

      def purchaseble?
        !@user.library.contents.alive.where(
          purchaseble_id: permitted_params[:purchaseble_id],
          purchaseble_type: permitted_params[:purchaseble_type]
        ).any?
      end
    end
  end
end
