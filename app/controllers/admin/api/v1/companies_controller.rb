module Admin
  module Api
    module V1
      class CompaniesController < BaseController
        before_action :authenticate_user!
        before_action :authorize_company!
        before_action :set_company, only: [:show, :update, :destroy]

        # GET /admin/api/v1/companies
        def index
          @companies = Company.includes(:users).all
          render_collection(@companies, Admin::Api::V1::CompanySerializer)
        end

        # GET /admin/api/v1/companies/:id
        def show
          render_resource(@company, Admin::Api::V1::CompanySerializer)
        end

        # POST /admin/api/v1/companies
        def create
          @company = Company.new(company_params)

          if @company.save
            render_resource(@company, Admin::Api::V1::CompanySerializer, status: :created)
          else
            render_error(@company.errors.full_messages.join(", "))
          end
        end

        # PATCH/PUT /admin/api/v1/companies/:id
        def update
          if @company.update(company_params)
            render_resource(@company, Admin::Api::V1::CompanySerializer)
          else
            render_error(@company.errors.full_messages.join(", "))
          end
        end

        # DELETE /admin/api/v1/companies/:id
        def destroy
          @company.destroy
          head :no_content
        end

        private

        def set_company
          @company = Company.find(params[:id])
        end

        def company_params
          params.require(:company).permit(:name)
        end

        def authorize_company!
          authorize! :manage, Company
        end
      end
    end
  end
end
