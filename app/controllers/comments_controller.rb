class CommentsController < ApplicationController

  before_filter :authorize, :except => [ :create ]
  before_filter :set_previous_url

  def create
    @post         = Post.permalink(params[:post_id], admin?).first
    @comment      = Comment.new(params[:comment].merge({ :post => @post, :personal_comment => admin? }))
    @comment_show = true

    if @comment.save
      Mailer.comment_notifier(@comment).deliver

      redirect_to "#{post_path(@post.permalink)}#commentinput", :notice => "Your comment was successfully submitted"
    else
      flash[:alert] = "Your comment submission failed due to some errors"
      render "posts/show"
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    post = @comment.post
    @comment.destroy

    redirect_to "#{permalink_url(post.permalink)}#commentinput", :notice => "The comment was successfully deleted"
  end
end
