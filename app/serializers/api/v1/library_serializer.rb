module Api
  module V1
    class LibrarySerializer
      attr_reader :library

      def initialize(library = nil)
        @library = library
      end

      def serialize
        return {} if contents.blank?

        result = contents.map do |content|
          {
            media: serialize_media(content.purchaseble),
            expires_at: content.expires_at.to_time.strftime('%m/%d/%Y-%H:%M:%S')
          }
        end
      end

      private

      def contents
        if @library
          @library.contents.alive.includes(:purchaseble).order(:expires_at)
        end
      end

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