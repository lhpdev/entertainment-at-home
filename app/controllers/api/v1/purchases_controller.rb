module Api
  module V1
    class PurchasesController < ActionController::Base
      skip_before_action :verify_authenticity_token

      def create
        result = Purchases::Create.call(params: permitted_params.merge({ user_id: params[:user_id] }))

        if result.success?
          render json: { status: 201, success: true, data: PurchaseSerializer.new(result.purchase).serialize }, status: 201
        else
          render json: { status: result.errors[:status], success: false, error_message: result.errors[:message] }, status: result.errors[:status]
        end
      end

      private

      def permitted_params
        params.require(:purchase).permit(:purchaseble_id, :purchaseble_type, :video_quality)
      end
    end
  end
end
