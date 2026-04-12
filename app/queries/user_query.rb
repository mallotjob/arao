class UserQuery
  def initialize(relation = User.all)
    @relation = relation
  end

  def search(params)
    relation = @relation.includes(:roles, :company).order(:created_at)

    # Apply search filter
    if params[:search].present?
      search_term = "%#{params[:search]}%"
      relation = relation.where(
        "first_name ILIKE ? OR last_name ILIKE ? OR email ILIKE ? OR username ILIKE ?",
        search_term, search_term, search_term, search_term
      )
    end

    # Apply role filter
    if params[:role].present?
      relation = relation.joins(:roles).where(roles: { name: params[:role] })
    end

    # Apply company filter
    if params[:company_id].present?
      relation = relation.where(company_id: params[:company_id])
    end

    # Pagination
    page = params[:page] || 1
    per_page = params[:per_page] || 10
    relation.page(page).per(per_page)
  end

  private

  attr_reader :relation
end
