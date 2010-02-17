class ApplicationController < ActionController::Base

  helper :all
  helper_method :admin?

  protect_from_forgery

  before_filter :initialize_last_edited

  private

    def admin?
      session[:logged_in]
    end

    def authorize
      unless admin?
        flash[:error_authentication] = true
        redirect_to login_url
      end
    end

    def save_previous_url
      session[:previous_page] = request.request_uri
    end

    def initialize_last_edited
      @last_updated_at = Post.all(:limit => 1, :order => "updated_at DESC").first.updated_at
    end

end
