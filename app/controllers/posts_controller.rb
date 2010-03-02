class PostsController < ApplicationController

  before_filter :authorize, :except => [ :index, :show ]
  before_filter :save_previous_url

  def index
    @posts = Post.blog

    initialize_posts
  end

  def show
    if admin?
      @post = Post.where(:permalink => params[:id]).first
    else
      @post = Post.active.where(:permalink => params[:id]).first
    end

    @comment = Comment.new({:post    => @post,
                            :snow    => flash[:snow_value],
                            :name    => flash[:name_value],
                            :email   => flash[:email_value],
                            :website => flash[:website_value],
                            :comment => flash[:comment_value]})

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
