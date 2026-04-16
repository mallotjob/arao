module Admin
  module Api
    module V1
      class UsersController < BaseController
        before_action :authenticate_user!
        before_action :set_user, only: [:show, :update, :destroy, :user_stats]
        before_action :authorize_user!

        # GET /admin/api/v1/users
        def index
          @users = UserQuery.new(User.for_actor(current_user)).search(params)
          render_collection(@users, Admin::Api::V1::UserSerializer, meta: meta_attributes(@users))
        end

        # GET /admin/api/v1/users/me
        def me
          render_resource(current_user, Admin::Api::V1::UserSerializer)
        end

        # GET /admin/api/v1/users/:id/stats
        def user_stats
          user_products = Product.where(beneficiary_id: @user.id)

          stats = {
            total_products: user_products.count,
            pending_products: user_products.where(aasm_state: "pending").count,
            completed_products: user_products.where(aasm_state: "completed").count,
            shipped_products: user_products.where(aasm_state: "shipped").count,
            delivered_products: user_products.where(aasm_state: "delivered").count
          }

          render_success(stats)
        end

        # PATCH/PUT /admin/api/v1/users/me
        def update_me
          if current_user.update(user_params)
            render_resource(current_user, Admin::Api::V1::UserSerializer)
          else
            render_error(current_user.errors.full_messages.join(", "))
          end
        end

        # PATCH/PUT /admin/api/v1/users/:id/password
        def update_password
          if current_user.valid_password?(password_params[:current_password])
            if current_user.update(password_params.except(:current_password))
              render_success({}, "Password updated successfully")
            else
              render_error(current_user.errors.full_messages.join(", "))
            end
          else
            render_error("incorrect_current_password")
          end
        end

        # GET /admin/api/v1/users/:id
        def show
          render_resource(@user, Admin::Api::V1::UserSerializer)
        end

        # POST /admin/api/v1/users
        def create
          @user = User.new(user_params)
          @user.created_by = current_user.id

          if @user.save
            render_resource(@user, Admin::Api::V1::UserSerializer, status: :created)
          else
            render_error(@user.errors.full_messages.join(", "))
          end
        end

        # PATCH/PUT /admin/api/v1/users/:id
        def update
          @user.updated_by = current_user.id

          if @user.update(user_params)
            render_resource(@user, Admin::Api::V1::UserSerializer)
          else
            render_error(@user.errors.full_messages.join(", "))
          end
        end

        # DELETE /admin/api/v1/users/:id
        def destroy
          @user.destroy
          head :no_content
        end

        private

        def set_user
          @user = User.find(params[:id])
        end

        def user_params
          permitted = params.require(:user).permit(:first_name, :last_name, :email, :username, :phone_number, :company_id,
          :all_access, :password, :password_confirmation, role_ids: [])

          permitted[:role_ids]&.reject!(&:blank?)
          permitted
        end

        def password_params
          params.require(:user).permit(:current_password, :password, :password_confirmation)
        end

        def authorize_user!
          case action_name
          when "me", "update_me", "update_password"
            # Users can always view and update their own profile
            nil
          when "user_stats"
            # Users can view their own stats, or others if they have manage permissions
            if @user.id == current_user.id
              nil
            else
              authorize! :manage, User
            end
          else
            authorize! :manage, User
          end
        end
      end
    end
  end
end
