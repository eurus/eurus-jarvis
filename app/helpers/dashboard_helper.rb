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

  def sabbatical_gone
    days = 0
    current_user.vacations.where("approve = true and cut = '年假' and created_at <= ?", Date.current.end_of_year).map{|v|
        v.duration
    }.reduce(:+) || 0
  end

  def translate_title (name)
    case name
    when "ceo"
      "首席执行官"
    when "director"
      "部门总监"
    when "pm"
      "项目经理"
    when "stuff"
      "普通猿工"
    else
      "实习猿工"
    end
    
  end

  def get_done(user)
    user.projects.done.count || 0
  end

  def get_errand(user)
    user.total_fee || 0
  end
end
