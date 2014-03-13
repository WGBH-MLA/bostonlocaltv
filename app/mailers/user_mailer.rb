class UserMailer < ActionMailer::Base
  default from: "bostonlocaltv.wgbh.org"

  def digitization_approval_email(user, artifact)
  	@user, @artifact = user, artifact
  	mail(to: @user.email, subject: 'Your digitization request has been approved')
  end

   def digitization_blocked_email(user, artifact)
  	@user, @artifact = user, artifact
  	mail(to: @user.email, subject: 'Unable to digitize your requested item')
  end
end
