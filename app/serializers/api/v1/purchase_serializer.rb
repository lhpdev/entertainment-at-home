module Api
  module V1
    class PurchaseSerializer
      attr_reader :purchase

      def initialize(purchase)
        @purchase = purchase
      end

      def serialize
        return {} if @purchase.blank?

        @purchase
      end
    end
  end
end