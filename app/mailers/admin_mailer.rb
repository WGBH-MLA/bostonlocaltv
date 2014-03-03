class AdminMailer < ActionMailer::Base
  default from: "no-reply@wgbh.org"

  def request_notification_email(user, artifact)
  	@user, @artifact = user, artifact
  	mail(to: "bostonlocaltv@wgbh.org", subject: 'New Digitization Request')
  end
end
