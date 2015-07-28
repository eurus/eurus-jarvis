module PlansHelper
  def status_highlight(status)
    case status
    when "done"
      "success"
    when "overtime"
      "danger"
    else
      ""
    end
  end
end
