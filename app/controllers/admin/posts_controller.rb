class Admin::PostsController < Admin::AdminController

  def index
    initialize_posts

    @posts           = Post.sorted.paginate(:page => params[:page], :per_page => 10)
    @total_posts     = Post.posts.count
    @total_scratches = Post.scratches.count
    @total_hidden    = Post.inactive.count
    @total_comments  = Comment.count
  end

  def new
    initialize_new_post

    @post = Post.new
  end

  def edit
    initialize_edit_post

    @post = Post.find(params[:id])
  end

  def create
    @post = Post.new(params[:post])

    if @post.save
      redirect_to admin_posts_path, :notice => "The blog post was created"
    else
      flash[:alert] = "There was an error while trying to create a new blog post"
      render :new
    end
  end

  def update
    @post = Post.find(params[:id])

   if @post.update_attributes(params[:post])
     redirect_to admin_posts_path, :notice => "The blog post was edited"
   else
     flash[:alert] = "There was an error while trying to edit the blog post"
     render :edit
   end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    redirect_to admin_posts_path, :notice => "The blog post was deleted"
  end

  private

    def initialize_posts
      @title         = "blog"
      @selected      = "blog"
      @keep_linking  = true
    	@admin_section = "new"
    end

    def initialize_new_post
      @title         = "blog"
      @selected      = "blog"
      @keep_linking  = true
    	@admin_section = "overview_no_new"
    end

    def initialize_edit_post
      @title         = "blog"
      @selected      = "blog"
      @keep_linking  = true
    	@admin_section = "overview"
    end

end