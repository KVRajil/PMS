module TaskLibMethods
  def validate_start_and_end_date
    start_date = Time.zone.parse(task_params[:start_date].to_s)
    end_date   = Time.zone.parse(task_params[:end_date].to_s)
    return unless start_date.present? && end_date.present? && start_date > end_date

    raise PmsErrors::ValidationError, 'start date cannot be greater than end date'
  end
end
