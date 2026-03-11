# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user

    user.roles.includes(:permissions).each do |role|
      role.permissions.each do |permission|
        can permission.action.to_sym, permission.subject.constantize
      end
    end
  end
end
