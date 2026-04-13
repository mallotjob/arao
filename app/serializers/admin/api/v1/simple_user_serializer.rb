module Admin
  module Api
    module V1
      class SimpleUserSerializer < ApplicationSerializer
        attributes :id, :full_name

        def full_name
          "#{object.first_name} #{object.last_name}"
        end
      end
    end
  end
end
