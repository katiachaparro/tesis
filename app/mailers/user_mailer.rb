class UserMailer < ApplicationMailer
  def welcome_user(user, organization, pw)
    @user = user
    @organization = organization
    @pw = pw
    mail(to: recipient(user), subject: t('mailer.user_mailer.subject'))
  end
end
