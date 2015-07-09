class DashboardController < ApplicationController
  # skip_before_action :authenticate_user!, only: [:index]

  def index
    @client = YahooWeather::Client.new;
    @response = @client.fetch(12712492)
  end

  def setting
    @user = current_user
  end

  def update_setting
    respond_to do |format|
      if current_user.update(user_params)
        format.html {redirect_to settings_path, notice:"更新个人信息成功"}
      else
        format.html {redirect_to settings_path, notice:"更新个人信息失败"}
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :nickname, :password,:avatar)
  end

end
