module Admin
  module Api
    module V1
      class BaseController < AdminController
        # Default namespace for V1 API
        protected

        def default_serializer_options
          {
            each_serializer: nil,
            serializer: nil
          }
        end

        def render_json(data, options = {})
          serializer = options.delete(:serializer)
          each_serializer = options.delete(:each_serializer)

          if data.respond_to?(:each)
            render json: data, each_serializer: each_serializer, **options
          else
            render json: data, serializer: serializer, **options
          end
        end

        def render_error(message, status = :unprocessable_entity)
          render json: { error: message }, status: status
        end

        def render_success(data = {}, message = nil, status = :ok)
          response = data.dup
          response[:message] = message if message
          render json: response, status: status
        end

        def render_collection(collection, serializer_class, options = {})
          render json: collection, each_serializer: serializer_class, **options
        end

        def render_resource(resource, serializer_class, options = {})
          render json: resource, serializer: serializer_class, **options
        end
      end
    end
  end
end
