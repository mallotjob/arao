module CompanyScoped
  extend ActiveSupport::Concern

  class_methods do
    def for_actor(actor)
      return all if actor&.all_access?
      where(company_id: actor&.company_id)
    end
  end
end
