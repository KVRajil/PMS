class UpdateTaskService
  include TaskLibMethods
  attr_reader :project, :task, :task_params

  def initialize(project:, task:, task_params:)
    @project = project
    @task = task
    @task_params = task_params
  end

  def call
    validate_start_and_end_date
    task.update!(task_params)
  end
end
