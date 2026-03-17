# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user

    # return true if user.all_access?

    user.roles.includes(:permissions).each do |role|
      role.permissions.each do |permission|
        can permission.action.to_sym, permission.subject.constantize
      end
    end
  end

  def to_list
    permissions = rules.each_with_object({}) do |rule, hash|
      rule.subjects.each do |subject|
        key = subject.to_s

        hash[key] ||= []
        hash[key] += rule.actions.map(&:to_s)
      end
    end

    permissions.transform_values(&:uniq)
  end
end
