class CommentsController < ApplicationController

  before_filter :authorize, :except => [ :create ]
  before_filter :save_previous_url

  def create
    @post = Post.find_by_permalink(params[:post_id])
    @comment = Comment.new(params[:comment].merge(:post => @post))
    if admin?
      @comment.name             = "Jelle Vandebeeck"
      @comment.email            = "jelle@fousa.be"
      @comment.website          = "http://www.fousa.be"
      @comment.snow             = "cold"
      @comment.personal_comment = true
    end
    if @comment.save
      FousaMailer.deliver_comment(@comment)
      flash[:notice] = true
    else
      flash[:error] = true

      flash[:name_value]    = @comment.name
      flash[:email_value]   = @comment.email
      flash[:website_value] = @comment.website
      flash[:comment_value] = @comment.comment
      flash[:snow_value]    = @comment.snow

      flash[:name_error]    = @comment.errors.invalid?(:name)
      flash[:email_error]   = @comment.errors.invalid?(:email)
      flash[:website_error] = @comment.errors.invalid?(:website)
      flash[:comment_error] = @comment.errors.invalid?(:comment)
      flash[:snow_error]    = @comment.errors.invalid?(:snow)
    end
    redirect_to post_path(@post.permalink) + "#commentinput"
  end

  def destroy
    @comment = Comment.find(params[:id])
    post = @comment.post
    @comment.destroy

    flash[:notice_delete] = true

    redirect_to permalink_url(post.permalink) + "#commentinput"
  end
end
