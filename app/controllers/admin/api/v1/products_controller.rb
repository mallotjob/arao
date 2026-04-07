module Admin
  module Api
    module V1
      class ProductsController < BaseController
        before_action :authenticate_user!
        before_action :authorize_product!
        before_action :set_product, only: [:show, :update, :destroy]

        # GET /admin/api/v1/products
        def index
          @products = Product.includes(:beneficiary, :company).all
          render_collection(@products, Admin::Api::V1::ProductSerializer)
        end

        # GET /admin/api/v1/products/:id
        def show
          render_resource(@product, Admin::Api::V1::ProductSerializer)
        end

        # POST /admin/api/v1/products
        def create
          @product = Product.new(product_params)

          if @product.save
            render_resource(@product, Admin::Api::V1::ProductSerializer, status: :created)
          else
            render_error(@product.errors.full_messages.join(", "))
          end
        end

        # PATCH/PUT /admin/api/v1/products/:id
        def update
          if @product.update(product_params)
            render_resource(@product, Admin::Api::V1::ProductSerializer)
          else
            render_error(@product.errors.full_messages.join(", "))
          end
        end

        # PATCH /admin/api/v1/products/:id/status
        # def update_status
        #   event = params[:event]&.to_sym

        #   if event && @product.send("may_#{event}?")
        #     if @product.send(event)
        #       render_resource(@product, Admin::Api::V1::ProductSerializer)
        #     else
        #       render_error("Cannot transition from #{@product.aasm_state} to #{event}")
        #     end
        #   else
        #     render_error("Invalid event: #{event}")
        #   end
        # end

        # DELETE /admin/api/v1/products/:id
        def destroy
          @product.destroy
          head :no_content
        end

        private

        def set_product
          @product = Product.find(params[:id])
        end

        def product_params
          params.require(:product).permit(
            :commodity,
            :height,
            :length,
            :width,
            :quantity,
            :weight,
            :shipping_time_id,
            :type_config_id,
            :beneficiary_id
          )
        end

        def authorize_product!
          authorize! :manage, Product
        end
      end
    end
  end
end
