module Admin
  class AdminController < ApplicationController
    before_action :authenticate_user!

    def home
      @abilities = current_ability.to_list.to_json
    end
  end
end
