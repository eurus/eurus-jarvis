class NotifyMailer < ApplicationMailer
  layout 'mailer'
  def welcome(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end

  def weekly_report(user,report)
    @user = user
    @report = report
    mail(to: @user.email, subject: "你有一封特别周报")
  end


end
