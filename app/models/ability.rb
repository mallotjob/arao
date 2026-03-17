# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    @user = user
    return unless @user

    if @user.all_access?
      can :manage, :all
      return
    end

    permissions.each do |permission|
      subject = safe_constantize(permission.subject)
      next unless subject

      can permission.action.to_sym, subject
    end
  end

  def to_list
    rules.each_with_object({}) do |rule, hash|
      rule.subjects.each do |subject|
        key = subject.to_s

        hash[key] ||= []
        hash[key] += rule.actions.map(&:to_s)
      end
    end
  end

  private

  def permissions
    @permissions ||= Permission
      .joins(:roles)
      .where(roles: { id: @user.role_ids })
      .distinct
  end

  def safe_constantize(name)
    name.constantize
  rescue NameError
    nil
  end
end
