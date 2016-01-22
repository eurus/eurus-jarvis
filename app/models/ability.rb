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

      if user.role == 'pm' or 'derector'
        can :users, :all
        can :groups, :all
        can :projects, :all
      end

    end
  end
end
