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

  def ceo?
    current_user.role == "ceo"
  end

  def director?
    current_user.role == "director"
  end

  def pm?
    current_user.role == "pm"
  end

  def staff?
    current_user.role == "staff"
  end

  def intern?
    current_user.role == "intern"
  end

  def user_tree(user)
    puts "user: #{user.username}"
    puts "buddies: #{user.buddies.length}"
    if user.buddies.length > 0
      content_tag(:ul) do
        content_tag(:li) do
          concat link_to(user.username, '#')
          user.buddies.each do |u|
            concat user_tree u
          end
        end
      end
    else
      content_tag(:li, link_to(user.username, '#'))
    end
  end

end
