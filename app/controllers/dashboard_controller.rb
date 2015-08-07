class DashboardController < ApplicationController
  skip_before_action :authenticate_user!, only: [:check_on_time]
  
  include Common
  def index

    num = Artical.count
    if num==0
      num=1
    end
    num = Random.new.rand(num)
    @art = Artical.all[num]

    @config = YAML.load_file("config/weather.yml")["code"]
    @response = YahooWeather::Client.new.fetch(12712492)
    if @response
      code = @response.condition.code
      @icon = @config[code.to_i]['icon']
    end

    ##出差天数
    @errand_count = current_user.errands.this_year.map { |e| (e.end_at - e.start_at).to_f }.reduce(:+) || 0

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

  def check_on_time
    ap params
    @check = {
      status: 200,
      info: "welcome"
    }
    respond_to do |format|
      format.json { render json: @check, status: 200 }
    end
  end
  private

  def user_params
    params.require(:user).permit(:username, :nickname,
                                 :password,:avatar,:birthday,
                                 :realname,:gender)
  end

end
