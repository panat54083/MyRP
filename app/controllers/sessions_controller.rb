class SessionsController < ApplicationController

    skip_before_action :set_current_user
    def create
    #   auth=request.env["omniauth.auth"]
      user=Moviegoer.where(:provider => auth["provider"], :uid => auth["uid"]).first ||
        Moviegoer.create_with_omniauth(auth)
      session[:user_id] = user.id
      redirect_to movies_path
    end
    def destroy
      session.delete(:user_id)
      flash[:notice] = 'Logged out successfully.'
      redirect_to movies_path
    end
    private
    def auth
        request.env['omniauth.auth']
    end
  end
