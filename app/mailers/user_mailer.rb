class UserMailer < ActionMailer::Base
  default from: "bostonlocaltv.wgbh.org"

  def digitization_approval_email(user, artifact)
  	@user, @artifact = user, artifact
  	mail(to: @user.email, subject: 'Your Digitization Request Is Approved!')
  end

   def digitization_denial_email(user, artifact)
  	@user, @artifact = user, artifact
  	mail(to: @user.email, subject: 'We are sorry, your digitization request was denied')
  end
end
