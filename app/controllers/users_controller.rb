class UsersController < ApplicationController

  before_filter :require_admin

  def index
    @users = User.find(:all)
  end
  
  def signup
    @user = User.new(params[:user])
    if request.post?
      if @user.save
        session[:user] = User.authenticate(@user.password)
        flash[:message] = "Signup successful"
        redirect_to root_url
      else
        flash[:warning] = "Signup unsuccessful"
      end
    end
  end

  def login
    if request.get?
      #logout user
      self.logged_user = nil
    else
      user = User.authenticate(params[:user][:password])
      if not user.nil?
        flash[:message]  = "Login successful"
        self.logged_user = user
        redirect_to root_url
      else
        flash[:warning] = "Login unsuccessful"
      end
    end
  end

  def logout
    session[:user] = nil
    flash[:message] = 'Logged out'
    self.logged_user = nil
    redirect_to root_url
  end

  def forgot_password
    if request.post?
      u= User.find_by_email(params[:user][:email])
      if u and u.send_new_password
        flash[:message]  = "A new password has been sent by email."
        redirect_to :action=>'login'
      else
        flash[:warning]  = "Couldn't send password"
      end
    end
  end

  def change_password
    @user=session[:user]
    if request.post?
      @user.update_attributes(:password=>params[:user][:password], :password_confirmation => params[:user][:password_confirmation])
      if @user.save
        flash[:message]="Password Changed"
      end
    end
  end
  
end
