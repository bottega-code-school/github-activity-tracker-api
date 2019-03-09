module AuthenticationConcern
  extend ActiveSupport::Concern

  included do
    before_action :set_current_user
  end

  def set_current_user
    puts "CHECK LOGIN" * 500, session[:user_id], "check login" * 500
    if session[:user_id]
      @current_user = User.find(session[:user_id])
    end
  end
end
