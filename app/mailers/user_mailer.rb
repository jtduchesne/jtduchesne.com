class UserMailer < ApplicationMailer
  before_action { @user = params[:user] }
  
  def verification
    mail(to: @user.email)
  end
  
  def connection
    @otp = params[:otp]
    mail(to: @user.email)
  end
end
