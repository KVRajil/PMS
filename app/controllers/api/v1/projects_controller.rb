module Api
  module V1
    class Api::V1::ProjectsController < Api::V1::ApiController
      before_action :authenticate_user!
      before_action :set_project, only: %i[show edit update destroy]

      api :GET, 'api/v1/projects', 'List all projects'
      param :page,     String, desc: 'Page number for pagination',      required: false
      param :per_page, String, desc: 'Records per page for pagination', required: false
      def index
        @projects = Project.includes(:user).ordered.page(params[:page]).per(params[:per_page])
      end

      api :GET, 'api/v1/projects/:id', 'Get project details'
      def show; end

      api :POST, 'api/v1/cms/projects', 'Create a new project '
      param :title, String, desc: 'Project title', required: true
      param :description, String, desc: 'Project description', required: true
      def create
        @project = current_user.projects.create!(project_params)

        head :ok
      end

      api :PUT, 'api/v1/cms/projects', 'Update an existing project'
      param :title, String, desc: 'Project title', required: false
      param :description, String, desc: 'Project description', required: false
      def update
        @project.update!(project_params)

        head :ok
      end
      api :DELETE, 'api/v1/cms/projects/:', 'Delete an existing project'
      def destroy
        @project.destroy!

        head :ok
      end

      private

      def set_project
        @project = Project.find(params[:id])
      end

      def project_params
        params.require(:project).permit(:title, :description)
      end
    end
  end
end
