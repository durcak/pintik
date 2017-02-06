class Ability
  include CanCan::Ability

  def initialize(user)
    alias_action :create, :read, :update, :destroy, to: :crud

    if user.has_role?(:admin)
      can :manage, :all
    else
      can :crud, Pin, user_id: user.id
      can :read, :all
      can [:comments, :follow, :upvote, :downvote], Pin
      can [:create, :destroy], Comment, user_id: user.id
      can [:accept_request, :decline_request, :remove_friend], User
    end
  end
end
