module VacationsHelper

  def status(s)
    s == true ? "已通过" : "待确认"
  end

end
