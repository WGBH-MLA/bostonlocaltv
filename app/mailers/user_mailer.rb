class UserMailer < ActionMailer::Base
  default from: "bostonlocaltv@wgbh.org"

  def digitization_approval_email(user, artifact)
  	@user, @artifact = user, artifact
  	mail(to: @user.email, subject: 'Your digitization request has been approved')
  end

   def digitization_blocked_email(user, artifact)
  	@user, @artifact = user, artifact
  	mail(to: @user.email, subject: 'Unable to digitize your requested item')
  end

  def request_withdrawn_email(user, artifact)
  	@user, @artifact = user, artifact
  	mail(to: @user.email, subject: 'Your request for digitization has been withdrawn')
  end

  def digitization_published_email(user, artifact)
    @user, @artifact = user, artifact
    mail(to: @user.email, subject: 'The item you requested has been published')
  end
end
