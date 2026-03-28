module Admin
  module Api
    class UsersController < AdminController
      before_action :authenticate_user!
      before_action :authorize_user!
      before_action :set_user, only: [:show, :update, :destroy]

      # GET /admin/api/users
      def index
        @users = User.includes(:roles, :company).all
        render json: @users
      end

      # GET /admin/api/users/me
      def me
        render json: current_user.as_json(include: [:roles, :company])
      end

      # GET /admin/api/users/me/stats
      def stats
        user_products = Product.where(beneficiary_id: current_user.id)

        stats = {
          totalProducts: user_products.count,
          pendingProducts: user_products.where(aasm_state: "pending").count,
          completedProducts: user_products.where(aasm_state: "completed").count,
          shippedProducts: user_products.where(aasm_state: "shipped").count,
          deliveredProducts: user_products.where(aasm_state: "delivered").count
        }

        render json: stats
      end

      # PATCH/PUT /admin/api/users/me
      def update_me
        if current_user.update(user_params)
          render json: current_user.as_json(include: [:roles, :company])
        else
          render json: { errors: current_user.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /admin/api/users/me/password
      def update_password
        if current_user.valid_password?(password_params[:current_password])
          if current_user.update(password_params.except(:current_password))
            render json: { message: "Password updated successfully" }
          else
            render json: { errors: current_user.errors.full_messages }, status: :unprocessable_entity
          end
        else
          render json: { error: "Current password is incorrect" }, status: :unprocessable_entity
        end
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

      def password_params
        params.require(:user).permit(:current_password, :password, :password_confirmation)
      end

      def authorize_user!
        case action_name
        when "me", "stats", "update_me", "update_password"
          # Users can always view and update their own profile
          nil
        else
          authorize! :manage, User
        end
      end
    end
  end
end
