module  Common
  extend ActiveSupport::Concern
  def get_user_annual_vacation(user)
    ap user.join_at
  end


end
