module Admin
  module Api
    module V1
      class RolesController < BaseController
        before_action :authenticate_user!
        before_action :authorize_role!
        before_action :set_role, only: [:show, :update, :destroy]

        # GET /admin/api/v1/roles
        def index
          @roles = Role.includes(:permissions, :users).all
          render_collection(@roles, Admin::Api::V1::RoleSerializer)
        end

        # GET /admin/api/v1/roles/:id
        def show
          render_resource(@role, Admin::Api::V1::RoleSerializer)
        end

        # POST /admin/api/v1/roles
        def create
          @role = Role.new(role_params)

          if @role.save
            render_resource(@role, Admin::Api::V1::RoleSerializer, status: :created)
          else
            render_error(@role.errors.full_messages.join(", "))
          end
        end

        # PATCH/PUT /admin/api/v1/roles/:id
        def update
          if @role.update(role_params)
            render_resource(@role, Admin::Api::V1::RoleSerializer)
          else
            render_error(@role.errors.full_messages.join(", "))
          end
        end

        # DELETE /admin/api/v1/roles/:id
        def destroy
          @role.destroy
          head :no_content
        end

        private

        def set_role
          @role = Role.find(params[:id])
        end

        def role_params
          params.require(:role).permit(:name, :description)
        end

        def authorize_role!
          authorize! :manage, Role
        end
      end
    end
  end
end
