module Api
  module V1
    class SeasonSerializer
      attr_reader :season

      def initialize(season)
        @season = season
      end

      def serialize
        return {} if @season.blank?

        {
           id: @season.id,
           title: @season.title,
           plot: @season.plot,
           number: @season.number,
           created_at: @season.created_at.strftime('%m/%d/%Y-%H:%M:%S'),
        }
      end
    end
  end
end