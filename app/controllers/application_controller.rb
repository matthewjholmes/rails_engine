class ApplicationController < ActionController::API

  rescue_from ::ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ::ActiveRecord::RecordInvalid, with: :record_invalid

  def record_not_found(exception)
    render json: { error: exception.message }, status: 404
    return
  end

  def record_invalid(exception)
    render json: { error: exception.message }, status: 404
    return
  end

end
