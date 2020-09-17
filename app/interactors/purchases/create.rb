module Purchases
  class Create
    include Interactor

    delegate :params, to: :context

    def call
      @user = User.find_by(id: params[:user_id])

      if @user
        if content
          if purchaseble?
            purchase = PurchaseOption.create!(library: @user.library,
                                                       purchaseble_id: params[:purchaseble_id],
                                                       purchaseble_type: params[:purchaseble_type],
                                                       video_quality: params[:video_quality].to_sym)
            if purchase
              context.purchase = purchase
            else
              context.fail!(errors: purchase.errors.messages)
            end
          else
            context.fail!(errors: {
              message: "operation not allowed because there is an alive #{params[:purchaseble_type]} with id: #{params[:purchaseble_id]} in the library",
              status: 400 }
            )
          end
        else
          context.fail!(errors: { message: "#{params[:purchaseble_type]} not found with id: #{params[:purchaseble_id]}", status: 404 })
        end
      else
        context.fail!(errors: { message: "user not found with id: #{params[:user_id]}", status: 404 })
      end
    end

    private

    def content
      @content ||= find_content
      context.content = @content
    end

    def find_content
      if params[:purchaseble_type] == 'Movie'
        Movie.find_by(id: params[:purchaseble_id])
      else
        Season.find_by(id: params[:purchaseble_id])
      end
    end

    def purchaseble?
      !@user.library.contents.alive.where(
        purchaseble_id: params[:purchaseble_id],
        purchaseble_type: params[:purchaseble_type]
      ).any?
    end
  end
end