class CreateTaskService
  include TaskLibMethods
  attr_reader :project, :task_params

  def initialize(project:, task_params:)
    @project = project
    @task_params = task_params
  end

  def call
    validate_start_and_end_date
    project.tasks.create!(task_params)
  end
end
