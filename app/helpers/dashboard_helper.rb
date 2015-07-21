module DashboardHelper
  def sabbatical_remain
    if Time.current < current_user.join_at + 1.year
      0
    elsif Time.current >= (current_user.join_at + 1.year)
      if Time.current.year == (current_user.join_at + 1.year).year
        ((Time.current.end_of_year - current_user.join_at - 1.year)/1.day).round*6/365
      elsif  Time.current < (current_user.join_at + 10.year)
        6
      elsif Time.current >= (current_user.join_at + 10.year) && Time.current < (current_user.join_at + 20.year)
        10
      else
        15
      end
    end

  end

  def sabbatical_gone
    days = 0
    current_user.vacations.where("approve = true and cut = '年假' and created_at <= ?", Time.current.end_of_year).map{|v|
        ((v.to-v.start)/1.day).to_f
    }.reduce(:+) || 0
  end
end
