module Api
  module V1
    class TasksController < ApiController
      before_action :authenticate_user!
      before_action :set_project, only: %i[index show create update destroy]
      before_action :set_task, only: %i[show update destroy]

      api :GET, 'api/v1/projects/:project_id/tasks', 'List all tasks under a project'
      param :status, Task::STATUSES, desc: 'Task status', required: false
      param :assignee_id, :number, desc: 'Assignee user id', required: false
      param :reporter_id, :number, desc: 'Reporter user id', required: false
      param :page, :number, desc: 'Page number for pagination', required: false
      param :per_page, :number, desc: 'Records per page for pagination', required: false
      def index
        @tasks = @project.tasks.includes(:assignee, :reporter).ordered.page(params[:page]).per(params[:per_page])
                         .ransack(status_eq: params[:status], assignee_id: params[:assignee_id],
                                  reporter_id: params[:reporter_id]).result

      end

      api :GET, 'api/v1/projects/:project_id/tasks/:id', 'Get task details'
      def show; end

      api :POST, 'api/v1/projects/:project_id/tasks', 'Create a new task '
      param :title, String, desc: 'Task title', required: true
      param :description, String, desc: 'Task description', required: false
      param :assignee_id, Integer, desc: 'Assignee id', required: false
      param :reporter_id, Integer, desc: 'Reporter id', required: false
      param :status, Task::STATUSES, desc: 'Status', required: false
      param :start_time, String, desc: 'Start time', required: false
      param :end_time, String, desc: 'End time', required: false
      def create
        ::CreateTaskService.new(project: @project, task_params: task_params).call

        head :ok
      end

      api :PUT, 'api/v1/projects/:project_id/tasks/:id', 'Update an existing task'
      param :title, String, desc: 'Task title', required: false
      param :description, String, desc: 'Task description', required: false
      param :assignee_id, Integer, desc: 'Assignee id', required: false
      param :reporter_id, Integer, desc: 'Reporter id', required: false
      param :status, Task::STATUSES, desc: 'Status', required: false
      param :start_time, String, desc: 'Start time', required: false
      param :end_time, String, desc: 'End time', required: false
      def update
        ::UpdateTaskService.new(project: @project, task: @task, task_params: task_params).call

        head :ok
      end
      api :DELETE, 'api/v1/projects/:project_id/tasks/:id', 'Delete an existing task'
      def destroy
        @task.destroy!

        head :ok
      end

      private

      def set_project
        @project = Project.find(params[:project_id])
      end

      def set_task
        @task = @project.tasks.find(params[:id])
      end

      def task_params
        params.require(:task).permit(:title, :description, :project_id, :assignee_id,
                                     :reporter_id, :status, :start_date, :end_date)
      end
    end
  end
end
