module Admin
  class AdminController < ApplicationController
    before_action :authenticate_user!

    def home
    end
  end
end
