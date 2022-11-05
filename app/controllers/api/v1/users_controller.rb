module Api
  module V1
    class UsersController < ApiController
      before_action :authenticate_user!

      api :GET, 'api/v1/users', 'List users'
      param :page,     :number, desc: 'Page number for pagination',      required: false, default_value: 1
      param :per_page, :number, desc: 'Records per page for pagination', required: false, default_value: 10
      param :name_or_email, String, desc: 'Filter by name or email', required: false
      def index
        @users = User.ransack(username_cont: params[:name], email_cont: params[:name], m: 'or').result
                     .ordered.page(params[:page]).per(params[:per_page])

      end
    end
  end
end
