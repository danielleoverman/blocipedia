class UserMailer < ApplicationMailer
  default from: 'danielleoverman@hotmail.com'
  
  def new_user(user)
      @user = user
      mail(to: user.email, subject: "Welcome to Blocipedia!")
  end
    
end
