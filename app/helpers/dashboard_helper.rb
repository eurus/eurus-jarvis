module DashboardHelper
  def sabbatical_remain
    
    if current_user.join_at
      time_diff = (Date.current - current_user.join_at - 365).to_i
      if time_diff > 0
        if time_diff >  365
          6
        else
          d = current_user.join_at.end_of_year - current_user.join_at
          return ((d / 365) * 6).round
        end
      else
        0
      end
    else
      0
    end

  end
  def translate_title(name)
    name ? name : "猿攻"
  end
  def sabbatical_gone
    days = 0
    current_user.vacations.where("approve = true and cut = '年假' and created_at <= ?", Date.current.end_of_year).map{|v|
        v.duration
    }.reduce(:+) || 0
  end

  def get_done(user)
    user.projects.done.count || 0
  end

  def get_errand(user)
    user.total_fee || 0
  end
end
