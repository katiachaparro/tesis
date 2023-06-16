class ApplicationMailer < ActionMailer::Base
  default from: ENV['EMAIL_FROM']
  layout 'mailer'

  def recipient(user)
    ENV['EMAIL_TEST'] == 'true' ? ENV['EMAIL_TO_TEST'] : user.email
  end
end
