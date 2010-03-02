class SitesController < ApplicationController
  before_filter :save_previous_url

  def index
    initialize_services

    respond_to do |format|
      format.html
      format.xml { render :template => "layouts/sitemap", :layout => false }
    end
  end

  def show
    initialize_about
  end


  def new
    initialize_contact

    @contact = Contact.new
  end

  def create
    initialize_contact

    @contact = Contact.new(params[:contact])
    if @contact.valid?
      Mailer.deliver_contact(@contact)
      flash_notice
      redirect_to contact_url
    else
      flash_error
      render :action => "new"
    end
  end

  private

    def initialize_contact
      @title        = "contact"
      @selected     = "contact"
      @keep_linking = false
    end

    def initialize_about
      @title        = "about"
      @selected     = "about"
      @keep_linking = false
    end

    def initialize_services
      @title         = "services"
      @selected      = "services"
      @keep_linking  = false
      @keywords      = "fousa, blog, jelle vandebeeck, heverlee, twitter, dopplr, facebook, linked in, brightkite, flickr, delicious, last.fm, vimeo"
    	@admin_section = "services"
    end

    def flash_error
      flash[:notice] = false
      flash[:error] = true
    end

    def flash_notice
      flash[:notice] = true
      flash[:error] = false
    end

end
