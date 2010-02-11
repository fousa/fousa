class SearchController < ApplicationController

  before_filter :save_previous_url

  def index
    @query = params[:search]
    if @query.blank?
      @query = session[:search_query]
    else
      session[:search_query] = @query
    end

    @posts = Post.find(:all, :conditions => ["active = true AND (content LIKE ? OR title LIKE ?)", "%#{@query}%", "%#{@query}%"], :order => "created_at DESC").paginate :page => params[:page], :per_page => 10

    initialize_posts
  end

  private

    def initialize_posts
      @title         = "blog"
      @selected      = "blog"
      @keep_linking  = true
    	@admin_section = "overview"
    	@keywords      = (%w( fousa blog jelle\ vandebeeck heverlee) + @posts.map(&:keywords).flatten).join(",")
    end

end