module PmsErrors
  class BaseException < StandardError
    attr_reader :message, :status_code, :title, :status_text
  end

  class ValidationError < BaseException
    def initialize(message = 'ValidationError')
      @message = message
      @status_code = 422
      @status_text = :unprocessable_entity
      @title = self.class.name.underscore.to_s
    end
  end
end
