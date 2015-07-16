module VacationsHelper

  def status(s)
    s == true ? "已通过" : "待确认"
  end

  def issue(s)
    s == true ? "已发放" : "未发放"
  end

end
