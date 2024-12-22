# frozen_string_literal: true

module Devisable
  extend ActiveSupport::Concern
  included do
    # Include default devise modules. Others available are:
    # :confirmable, :timeoutable and :omniauthable
    devise :database_authenticatable, :rememberable, :trackable, :validatable, authentication_keys: [:login]
  end
end
