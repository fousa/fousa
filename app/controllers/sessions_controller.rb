class SessionsController < ApplicationController

  before_filter :authorize, :except => [ :new, :create, :show ]

  def new
    initialize_session

    @user        = User.new
    @hide_google = true
  end

  def create
    @user = User.new(params[:user])

    if @user.valid?
      session[:logged_in]  = true
      if session[:previous_page]
        previous_uri = session[:previous_page]
        session[:previous_page] = nil

        redirect_to previous_uri, :notice => "You are now logged in to this website"
      else
        redirect_to root_path, :notice => "You are now logged in to this website"
      end
    else
      redirect_to login_path, :alert => "You entered the wrong password"
    end
  end

  def destroy
    reset_session

    redirect_to login_path, :notice => "You are now logged off from this website"
  end

  def show
    initialize_not_found
  end

  private

    def initialize_session
      @title         = "login"
      @selected      = ""
      @keep_linking  = true
    end

    def initialize_not_found
      @title         = "404"
      @selected      = ""
      @keep_linking  = true
      @admin_section = "no"
    end

end
