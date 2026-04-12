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
          meta = options.delete(:meta)
          serialized = ActiveModelSerializers::SerializableResource.new(
            collection,
            each_serializer: serializer_class,
            adapter: :attributes
          ).as_json

          # Use model class name as the key (e.g., 'users', 'companies')
          model_name = collection.first&.class&.name&.downcase || "data"
          model_name = model_name.pluralize if collection.respond_to?(:length) && collection.length > 1

          response_data = { model_name.to_sym => serialized }
          response_data[:meta] = meta if meta

          render json: response_data
        end

        def render_resource(resource, serializer_class, options = {})
          render json: resource, serializer: serializer_class, **options
        end

        def meta_attributes(collection, extra_meta = {})
          is_paginated = collection.respond_to?(:total_count)
          base_meta = {
            total_count: is_paginated ? collection.total_count : collection.count
          }
          base_meta.merge(extra_meta)
        end
      end
    end
  end
end
