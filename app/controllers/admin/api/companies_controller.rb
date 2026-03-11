class Admin::Api::CompaniesController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_company!
  before_action :set_company, only: [:show, :update, :destroy]

  # GET /admin/api/companies
  def index
    @companies = Company.includes(:users).all
    render json: @companies.map { |company|
      company.as_json(include: :users).merge(user_count: company.users.count)
    }
  end

  # POST /admin/api/companies
  def create
    @company = Company.new(company_params)

    if @company.save
      render json: @company, status: :created
    else
      render json: { errors: @company.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /admin/api/companies/:id
  def update
    if @company.update(company_params)
      render json: @company
    else
      render json: { errors: @company.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /admin/api/companies/:id
  def destroy
    if @company.users.exists?
      render json: { error: "Cannot delete company with associated users" }, status: :unprocessable_entity
    else
      @company.destroy
      head :no_content
    end
  end

  private

  def set_company
    @company = Company.find(params[:id])
  end

  def company_params
    params.require(:company).permit(:name, :status)
  end

  def authorize_company!
    authorize! :manage, Company
  end
end
