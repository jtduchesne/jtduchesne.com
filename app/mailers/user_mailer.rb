class UserMailer < ApplicationMailer
  before_action { @user = params[:user] }
  
  def verification
    mail(to: @user.email)
  end
end
