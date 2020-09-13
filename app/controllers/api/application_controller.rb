module Api
  class ApplicationController < ActionController::API
    respond_to :json

    before_action do
      request.session_options[:skip] = true
    end
  end
end
