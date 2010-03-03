class ApplicationController < ActionController::Base

  helper :all
  helper_method :admin?

  protect_from_forgery

  before_filter :set_last_updated

  private

    def admin?
      session[:logged_in]
    end

    def authorize
      redirect_to login_url, :alert => "Not authorized, please login" unless admin?
    end

    def set_previous_url
      session[:previous_page] = request.request_uri
    end

    def set_last_updated
      @last_updated_at = Post.order("updated_at DESC").first.updated_at
    end

end
