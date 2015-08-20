class JarviscoreController < ApplicationController
  skip_before_action :verify_authenticity_token
  def wiki
    ap "wiki task"
    ap params
    if Rails.env == 'production'
      `cd /var/www/eurus-newbee && git pull origin master && jekyll build`
    else
      ap 'do nothing'
    end
    render nothing: true
  end
end
