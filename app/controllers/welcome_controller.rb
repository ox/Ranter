class WelcomeController < ApplicationController
  def index
    @posts = Post.find(:all)
  end

  def login
    if request.post?
      if params[:answer][:lol] == "dapopo"
        session[:admin] = true
        redirect_to :controller => "Welcome"
      else
        redirect_to :controller => "Welcome"
      end
    end
  end

  def logout
    session[:admin] = false
    redirect_to :controller => "Welcome"
  end
  

end
