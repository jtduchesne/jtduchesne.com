module AuthenticationHelper
  def login_as(user)
    allow_any_instance_of(ApplicationController).to receive(:session).and_return({user_id: user.id})
  end
  def login
    login_as FactoryBot.create(:user, :verified)
  end
  def logout
    allow_any_instance_of(ApplicationController).to receive(:session).and_return({})
  end
  
  def current_user; controller.try :send, :current_user; end
  def logged_in?;   controller.try :send, :logged_in?;   end
  def logged_out?;  controller.try :send, :logged_out?;  end
end
