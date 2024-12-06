class AdminAbility
  include CanCan::Ability

  def initialize(user)
    return unless user.present?
    return unless user.admin?

    can :manage, :all
    can :read, ActiveAdmin::Page
  end
end 