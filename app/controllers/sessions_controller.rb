class SessionsController < ApplicationController
  attr_accessor :inputEmail
  attr_accessor :inputPassword
  
  def new
    @inputEmail ||= ""
    @inputPassword ||= ""
  end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])
      if @user.activated?
        log_in @user
        params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
        redirect_back_or @user
      else
        message  = "Account not activated. "
        message += "Check your email for the activation link."
        flash[:warning] = message
        redirect_to root_url
      end
    else
      flash.now[:danger] = 'Invalid email/password combination'
      @inputEmail = params[:session][:email]
      @inputPassword = params[:session][:password]
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

end
