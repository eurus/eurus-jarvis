module VacationsHelper

  def status(s)
    s == true ? "已通过" : "待确认"
  end

  def issue(s)
    s == true ? "已发放" : "未发放"
  end

  def issue_status(verified, issued)
    if not verified
      "新"
    elsif issued
      "已发放"
    else
      "已审核"
    end
  end

end
