class ApplicationSerializer < ActiveModel::Serializer
  # Configure default settings for all serializers
  def self.default_attributes
    [:id, :created_at, :updated_at]
  end

  # Format timestamps consistently
  def created_at
    object.created_at.iso8601 if object.created_at
  end

  def updated_at
    object.updated_at.iso8601 if object.updated_at
  end

  # Handle nil objects gracefully
  def attributes(*args)
    hash = super
    return {} unless object
    hash
  end
end
