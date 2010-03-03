class SessionsController < ApplicationController

  before_filter :authorize, :except => [ :new, :create, :show ]

  def new
    initialize_session

    @hide_google = true
  end

  def create
    if authorized_with(params[:password])
      if session[:previous_page]
        previous_uri = session[:previous_page]
        session[:previous_page] = nil

        redirect_to previous_uri, :notice => "You are now logged in to this website"
      else
        redirect_to root_path, :notice => "You are now logged in to this website"
      end
    else
      initialize_session

      render :new, :alert => "You entered the wrong password"
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
