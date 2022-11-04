class ApplicationController < ActionController::API
  rescue_from Exception, with: :handle_exception
  rescue_from ActionController::UnknownFormat, with: :unknown_format
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from ActiveRecord::RecordInvalid, with: :invalid_data
  rescue_from Apipie::ParamMissing, with: :handle_param_missing_error
  rescue_from Apipie::ParamInvalid, with: :handle_param_invalid_error

  def handle_exception
    handle_development_exception
    code = 500
    title = 'generic_error'
    message = $ERROR_INFO.message
    render(json: { error: { message: message, code: code, title: title } }, status: :internal_server_error) && return
  end

  def handle_development_exception
    return unless Rails.env.development?

    logger.error $ERROR_INFO.message
    $ERROR_INFO.backtrace.each { |line| logger.error line }
  end

  def unknown_format
    code = 400
    title = 'Unknown Request Format'
    message = 'Cannot process this request.'
    render(json: { error: { message: message, code: code, title: title } }, status: :bad_request) && return
  end

  def not_found
    code = 404
    title = 'Record Not Found'
    message = if $ERROR_INFO.model.present?
                "Cannot find #{I18n.t("models.#{$ERROR_INFO.model}.readable", default: $ERROR_INFO.model)}."
              else
                $ERROR_INFO&.message.presence || 'Not found.'
              end
    render(json: { error: { message: message, code: code, title: title } }, status: :not_found) && return
  end

  def invalid_data
    code = 422
    title = 'Generic error'
    message = $ERROR_INFO.message
    render(json: { error: { message: message, code: code, title: title } }, status: :unprocessable_entity) && return
  end

  def handle_param_missing_error
    code = 422
    title = 'Params missing'
    message = $ERROR_INFO.message
    render(json: { error: { message: message, code: code, title: title } }, status: :unprocessable_entity) && return
  end
end
