class NotifyMailer < ApplicationMailer
  layout 'mailer'
  def welcome(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end

  def weekly_report(user,report,cc)
    @user = user
    @report = report
    mail(to: @user.email,cc: cc, subject: "你有一封特别的周报!")
  end

  def plan_maker(user, plan)
    @user = user
    @plan = plan
    mail(to: @user.email,subject: "Sounds like a plan!")
  end

end
