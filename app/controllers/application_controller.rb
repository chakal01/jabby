class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_user!
  before_action :load_camps

  def load_camps 
    @camps_navbar = Camp.all
    @blogs_navbar = Blog.all
  end

end
