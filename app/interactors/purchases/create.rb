module Purchases
  class Create
    include Interactor

    delegate :params, to: :context

    def call
      if user
        if content
          if purchaseble?
            purchase = create_purchase

            if purchase
              context.purchase = purchase

              delete_users_library_cache(@user.id)
            else
              context.fail!(errors: purchase.errors.messages)
            end
          else
            context.fail!(errors: {
              message: "operation not allowed. Same media alive in users the library",
              status: 400
            })
          end
        else
          context.fail!(errors: {
            message: "#{params[:purchaseble_type]} not found with id: #{params[:purchaseble_id]}",
            status: 404
          })
        end
      else
        context.fail!(errors: {
          message: "user not found with id: #{params[:user_id]}",
          status: 404
        })
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

    def user
      @user ||= User.find_by(id: params[:user_id])
    end

    def create_purchase
      PurchaseOption.create!(library: @user.library,
                                      purchaseble_id: params[:purchaseble_id],
                                      purchaseble_type: params[:purchaseble_type],
                                      video_quality: params[:video_quality].to_sym)
    end

    def purchaseble?
      !@user.library.contents.alive.where(
        purchaseble_id: params[:purchaseble_id],
        purchaseble_type: params[:purchaseble_type]
      ).any?
    end

    def delete_users_library_cache(user_id)
      Rails.cache.delete("User/#{user_id}/Library/Contents")
    end
  end
end