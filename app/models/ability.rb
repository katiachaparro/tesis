# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user, organization)
    return unless user.present?
    can :read, :all
    cannot :read, UserPermission
    cannot :report, Victim

    return unless user.super_admin? || user.admin?
    can :manage, :all

    return unless user.admin?
    cannot :create, Organization
  end
end
