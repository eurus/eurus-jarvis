module DashboardHelper
  def sabbatical_remain
    if current_user.join_at
      if Date.current < current_user.join_at + 1.year
      0
      elsif Date.current >= (current_user.join_at + 1.year)
        if Date.current.year == (current_user.join_at + 1.year).year
          ((Date.current.end_of_year - current_user.join_at - 1.year)/1.day).round*6/365
        elsif  Date.current < (current_user.join_at + 10.year)
          6
        elsif Date.current >= (current_user.join_at + 10.year) && Date.current < (current_user.join_at + 20.year)
          10
        else
          15
        end
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
end
