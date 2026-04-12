module Admin
  module Api
    module V1
      class UsersController < BaseController
        before_action :authenticate_user!
        before_action :authorize_user!
        before_action :set_user, only: [:show, :update, :destroy]

        # GET /admin/api/v1/users
        def index
          @users = User.includes(:roles, :company).order(:created_at)

          # Apply search filter
          if params[:search].present?
            search_term = "%#{params[:search]}%"
            @users = @users.where(
              "first_name ILIKE ? OR last_name ILIKE ? OR email ILIKE ? OR username ILIKE ?",
              search_term, search_term, search_term, search_term
            )
          end

          # Apply role filter
          if params[:role].present?
            @users = @users.joins(:roles).where(roles: { name: params[:role] })
          end

          # Apply company filter
          if params[:company_id].present?
            @users = @users.where(company_id: params[:company_id])
          end

          # Pagination
          page = params[:page] || 1
          per_page = params[:per_page] || 10
          @users = @users.page(page).per(per_page)

          render_collection(@users, Admin::Api::V1::UserSerializer, meta: meta_attributes(@users))
        end

        # GET /admin/api/v1/users/me
        def me
          render_resource(current_user, Admin::Api::V1::UserSerializer)
        end

        # GET /admin/api/v1/users/me/stats
        def stats
          user_products = Product.where(beneficiary_id: current_user.id)

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

          if @user.save
            render_resource(@user, Admin::Api::V1::UserSerializer, status: :created)
          else
            render_error(@user.errors.full_messages.join(", "))
          end
        end

        # PATCH/PUT /admin/api/v1/users/:id
        def update
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
          params.require(:user).permit(:first_name, :last_name, :email, :username, :phone_number, :company_id, :all_access)
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
end
