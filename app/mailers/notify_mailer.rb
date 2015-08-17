class NotifyMailer < ApplicationMailer
  layout 'mailer'
  def welcome(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end

  def weekly_report(user,report,cc)
    @user = user
    @report = report
    @start_date = @report.created_at.beginning_of_week.strftime("%Y-%m-%d")
    @end_date = @report.created_at.end_of_week.strftime("%Y-%m-%d")
    mail(to: @user.email,cc: cc, subject: "#{@report.user.try :realname} 周报 [#{@start_date} - #{@end_date}]")
  end

  def plan_maker(user, plan)
    @user = user
    @plan = plan
    mail(to: @user.email,subject: "#{@plan.user.try :realname} 新#{@plan.cut}计划：#{@plan.title}")
  end

  def plan_assigned(user, creator, plan)
    @user = user
    @creator = creator
    @plan = plan
    mail(to: @user.email,subject: "#{@creator.try :realname} 新建了#{@plan.cut}计划：#{@plan.title}")
  end

  def plan_overtime_warning(plan)
    @plan = plan
    mail(to:plan.creator.try(:email), cc: plan.user.try(:email), subject:"警告：#{plan.cut}计划已超期")
  end
end
