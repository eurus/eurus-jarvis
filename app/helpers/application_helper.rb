module ApplicationHelper
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def notice_tag(msg="")
    if msg && msg != ''
      content_tag(:div, '', class:'alert alert-info', role:'alert') do
        content_tag(:span, msg)+
        content_tag(:button, class:'close', :'data-dismiss'=>'alert') do
        content_tag(:span, fa_icon('times'), :'aria-hidden'=> 'true')
      end
      end
    end
  end

  def f_to_c (f)
      "#{((f.to_i - 36) / 1.8).round}℃"
  end

  def boss?
    current_user.role == "boss"
  end

  def stuff?
    current_user.role != "boss"
  end
end
