module Admin
  module Api
    module V1
      class SimpleUserSerializer < ApplicationSerializer
        attributes :id, :full_name
      end
    end
  end
end
