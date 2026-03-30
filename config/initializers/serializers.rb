# Configure Active Model Serializers
ActiveModelSerializers.config.adapter = :attributes
ActiveModelSerializers.config.key_transform = :camel_lower

# Set default serializer options
ActiveModelSerializers.config.default_includes = "**"
