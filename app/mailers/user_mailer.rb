class UserMailer < ActionMailer::Base
  default from: "hello@crowdfunder.com"

  def new_pledge(user, project, pledge)
  	@backer = user
  	@project = project
  	@pledge = pledge
    mail(to: @backer.email, subject: "You have backed a project")
  end

  def you_got_paid(user, project, pledge)
  	@owner = user
  	@project = project
  	@pledge = pledge
  	mail(to: @owner.email, subject: "You just got paid, son") 
  end
end
