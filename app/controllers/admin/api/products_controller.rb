class Admin::Api::ProductsController < AdminController
  before_action :authenticate_user!
  before_action :authorize_product!
  before_action :set_product, only: [:show, :update, :destroy, :update_status]

  # GET /admin/api/products
  def index
    @products = Product.includes(:beneficiary, :shipping_time, :type_config)
    render json: @products
  end

  # POST /admin/api/products
  def create
    @product = Product.new(product_params)

    if @product.save
      render json: @product, status: :created
    else
      render json: { errors: @product.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /admin/api/products/:id
  def update
    if @product.update(product_params)
      render json: @product
    else
      render json: { errors: @product.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /admin/api/products/:id/status
  def update_status
    status = params[:status]

    case status
    when "confirmed"
      @product.confirm!
    when "shipped"
      @product.ship!
    when "completed"
      @product.complete!
    when "delivered"
      @product.deliver!
    else
      render json: { error: "Invalid status" }, status: :unprocessable_entity
      return
    end

    render json: @product
  end

  # DELETE /admin/api/products/:id
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
      :tracking_number,
      :quantity,
      :weight,
      :length,
      :width,
      :heigth,
      :beneficiary_id,
      :shipping_time_id,
      :type_config_id
    )
  end

  def authorize_product!
    authorize! :manage, Product
  end
end
