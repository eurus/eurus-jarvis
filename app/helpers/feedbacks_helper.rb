module FeedbacksHelper
  def boss_or_stuff (id)
    if current_user.role == "boss"
      return "#{User.find(id).try :nickname}"
    else
      return "current_user.try :nickname"
    end
  end
end
