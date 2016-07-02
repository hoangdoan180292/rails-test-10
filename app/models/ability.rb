class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, Comment
    can :create, Comment
    can [:update, :destroy], Comment, { user: user }
  end
end
