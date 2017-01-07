class Ability
  include CanCan::Ability
 
  def initialize(user)
    user ||= User.new # guest user (not logged in)

    if user.role? 'developer'

      can :manage, :all

    elsif user.role? 'administrator'

      can :manage, Author
      can :manage, Category
      can :manage, Collection
      can :manage, Event
      can :manage, Order
      can :manage, Page
      can :manage, Post
      can :manage, Product
      can :manage, ActiveAdmin::Page, :name => "Settings"

      can :manage, User#, :id => user.id

      can :read, ActiveAdmin::Page, :name => "Dashboard"

    elsif user.role? 'author'

      can :manage, Post
      can :read, ActiveAdmin::Page, :name => "Dashboard"

    end

  end
end
