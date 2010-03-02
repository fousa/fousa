class SearchController < ApplicationController

  before_filter :save_previous_url

  def index
    @query = params[:search]

    @posts = @query.blank? ? [] : Post.active.where(["content LIKE ? OR title LIKE ?", "%#{@query}%", "%#{@query}%"]).paginate(:page => params[:page], :per_page => 10)

    initialize_posts
  end

  private

    def initialize_posts
      @title         = "blog"
      @selected      = "blog"
      @keep_linking  = true
    	@admin_section = "overview"
    	@keywords      = (%w( fousa blog jelle\ vandebeeck heverlee) + @posts.map(&:tag_list).flatten).join(",")
    end

end