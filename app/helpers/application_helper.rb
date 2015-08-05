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

  def user_tree_link(user)
    unless user.staff? or user.intern?
      link_to(
        content_tag(:div, user.realname) +
        content_tag(:div, user.username, class:'username'),
        '#',
        class:'popovers',
          tabindex:'0',
          role:'button',
          :"data-trigger"=>"focus",
          :"data-toggle"=>'popover',
          :"data-content"=>"#{
          link_to(fa_icon('pencil-square-o'), edit_user_group_path(id:user.id)) +
          link_to(fa_icon('recycle'), cancel_group_path(id:user.id),data: {:confirm => "确认撤销 #{user.username} 的职务?", text:"原职务：#{user.role}"}, :method => :delete)
          }")
    else
      link_to(
        content_tag(:div, user.realname) +
        content_tag(:div, user.username, class:'username'),
        '#')
    end
    end

    def user_tree(user)
    if user.buddies.length > 0
      content_tag(:li) do
        user_tree_link(user) +
        content_tag(:ul) do
          user.buddies.each do |u|
            concat user_tree(u)
          end
        end
      end
    else
      content_tag(:li, user_tree_link(user))
    end
  end

end
