# frozen_string_literal: true

class ApplicationController < ActionController::API
  rescue_from ::ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ::ActiveRecord::RecordInvalid, with: :record_invalid

  def record_not_found(exception)
    render json: { errors: exception.message }, status: 404
    nil
  end

  def record_invalid(exception)
    render json: { errors: exception.message }, status: 404
    nil
  end
end
