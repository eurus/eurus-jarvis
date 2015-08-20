class JarviscoreController < ApplicationController
  skip_before_action :verify_authenticity_token
  skip_before_action :authenticate_user!
  def wiki
    ap "wiki task"
    ap params
    if Rails.env == 'production'
      `cd /var/www/eurus-newbee && git pull origin master && rake hello`
    else
      ap 'do nothing'
    end
    render nothing: true
  end
end
