class PostsController < ApplicationController

  before_filter :authorize, :except => [ :index, :show ]
  before_filter :set_previous_url

  def index
    @posts = Post.blog

    initialize_posts

    respond_to do |format|
      format.html
      format.rss
    end
  end

  def show
    @post    = Post.permalink(params[:id], admin?).first
    @comment = Comment.new

    initialize_post
  end

  private

    def initialize_posts
      @title         = "blog"
      @selected      = "blog"
      @keep_linking  = false
    	@admin_section = "overview"
    	@keywords      = (%w( fousa blog jelle\ vandebeeck heverlee) + @posts.map(&:tag_list).flatten).join(",")
    end

    def initialize_post
      @title         = "blog"
      @selected      = "blog"
      @keep_linking  = true
    	@admin_section = "detail"
    	@admin_post    = @post.id
    	@keywords      = (%w( fousa blog jelle\ vandebeeck heverlee) + @post.tag_list).join(",")
    end

end
