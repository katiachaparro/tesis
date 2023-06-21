# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user, organization)
    return unless user.present?
    can :read, :all
    can :manage, Event
    can :manage, EventAction
    can :manage, Victim
    can :manage, ResourceRequest
    can :manage, AssistRequest

    cannot :manage, UserPermission
    cannot :manage, Resource
    cannot :manage, Organization
    cannot :report, Victim

    return unless user.super_admin? || user.admin?
    can :manage, :all

    return unless user.admin?
    cannot :create_main_organization, Organization
    cannot :manage, Resource
  end
end
