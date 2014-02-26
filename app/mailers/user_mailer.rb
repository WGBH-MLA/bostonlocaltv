class UserMailer < ActionMailer::Base
  default from: "bostonlocaltv.wgbh.org"

  def digitization_approval_email(user, artifact)
  	@user, @artifact = user, artifact
  	mail(to: @user.email, subject: 'Your Digitization Request Was Approved')
  end
end
