class Api::V1::BaseController < ApplicationController
  protect_from_forgery with: :null_session
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  skip_before_action :verify_authenticity_token

  before_action :destroy_session

  def not_found
    render json: {error: "record not found", status: 404}, status: 404
  end

  def destroy_session
    request.session_options[:skip] = true
  end
end