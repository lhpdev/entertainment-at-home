module Api
  module V1
    class PurchaseSerializer
      attr_reader :purchase

      def initialize(purchase)
        @purchase = purchase
      end

      def serialize
        return {} if @purchase.blank?

        {
           id: @purchase.id,
           library_id: @purchase.library_id,
           price: @purchase.price,
           video_quality: @purchase.video_quality,
           expires_at: @purchase.expires_at.to_time.strftime('%m/%d/%Y-%H:%M:%S'),
           purchased: serialize_media(@purchase.purchaseble)
        }
      end

      private

      def serialize_media(media)
        if media.class.to_s == 'Movie'
          MovieSerializer.new(media).serialize
        else
          SeasonSerializer.new(media).serialize
        end
      end
    end
  end
end