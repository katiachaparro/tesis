# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  def welcome_user
    # Set up a temporary order for the preview
    user = User.new(first_name: "Joe Smith", email: "joe@gmail.com")
    organization = Organization.new(name: 'Hospital')
    UserMailer.with(user: user).welcome_user(user, organization, 'asd')
  end
end
