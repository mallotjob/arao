module Admin
  module Api
    class UsersController < AdminController
      before_action :authenticate_user!
      before_action :authorize_read_user!
      before_action :authorize_user!, only: [:update, :destroy]
      before_action :set_user, only: [:show, :update, :destroy]

      # GET /admin/api/users
      def index
        @users = User.includes(:roles, :company).all
        render json: @users
      end

      # GET /admin/api/users/me
      def me
        render json: current_user.as_json(include: :roles)
      end

      # GET /admin/api/users/:id
      def show
        render json: @user
      end

      # POST /admin/api/users
      def create
        @user = User.new(user_params)

        if @user.save
          render json: @user, status: :created
        else
          render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /admin/api/users/:id
      def update
        if @user.update(user_params)
          render json: @user
        else
          render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # DELETE /admin/api/users/:id
      def destroy
        @user.destroy
        head :no_content
      end

      # POST /admin/api/users/:id/roles
      def add_role
        role = Role.find_by!(name: params[:role_name])
        @user.assign_role(role.name)
        render json: { message: "Role added successfully" }
      end

      # DELETE /admin/api/users/:id/roles/:role_name
      def remove_role
        @user.remove_role(params[:role_name])
        render json: { message: "Role removed successfully" }
      end

      private

      def set_user
        @user = User.find(params[:id])
      end

      def user_params
        params.require(:user).permit(:first_name, :last_name, :email, :username, :company_id, :password)
      end

      def authorize_user!
        authorize! :manage, User
      end

      def authorize_read_user!
        authorize! :read, User
      end
    end
  end
end
