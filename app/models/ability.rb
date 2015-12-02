class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    can :project_logs, :all
    if user.ceo?
      can :users, :all
      can :groups, :all
      can :overtimes, :all
      can :errands, :all
      can :vacations, :all
      can :projects, :all
      can :check, :all
      can :issue, :all
    else
      if user.occupation.split(",").include? 'office-manager'
        can :users, :all
        can :groups, :all
        can :overtimes, :all
        can :errands, :all
        can :vacations, :all
        can :projects, :all
        can :check, :all
        can :issue, :all
      end

      if user.occupation.split(",").include? 'office-assitant'
        can :groups, :all
        can :users, :all
        can :errands, :all
        can :projects, :all
        can :check, :all
      end

      if user.occupation.split(",").include? 'team-lead'
        can :users, :all
        can :groups, :all
        can :projects, :all
      end

      if user.occupation.split(",").include? 'tech-lead'
        can :users, :all
        can :groups, :all
        can :projects, :all
      end
    end
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
