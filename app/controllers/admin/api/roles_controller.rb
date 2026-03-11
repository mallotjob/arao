class Admin::Api::RolesController < AdminController
  before_action :authenticate_user!
  before_action :authorize_role!

  # GET /admin/api/roles
  def index
    @roles = Role.all
    render json: @roles
  end

  private

  def authorize_role!
    authorize! :manage, Role
  end
end
