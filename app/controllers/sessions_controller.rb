class SessionsController < ApplicationController

  before_filter :authorize, :except => [ :new, :create, :show ]

  def new
    initialize_session

    @hide_google = true
  end

  def create
    flash[:logoff_notice] = false
    if CONFIG["fousa"]["password"] == params[:password]
      flash[:login_notice] = true
      flash[:error]        = false
      session[:logged_in]  = true

      if session[:previous_page]
        previous_uri = session[:previous_page]
        session[:previous_page] = nil
        redirect_to previous_uri
      else
        redirect_to root_path
      end
    else
      initialize_session

      flash[:error] = true
      redirect_to :action => "new"
    end
  end

  def destroy
    reset_session
    flash[:login_notice]  = false
    flash[:logoff_notice] = true

    redirect_to login_path
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
