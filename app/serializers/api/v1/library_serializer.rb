module Api
  module V1
    class LibrarySerializer
      attr_reader :library

      def initialize(library = nil)
        @library = library
      end

      def serialize
        return {} if @library.purchase_options.blank?

        @library.purchase_options.alive.order(:expires_at)
      end
    end
  end
end