class CommentsController < ApplicationController

  before_filter :authorize, :except => [ :create ]
  before_filter :set_previous_url

  def create
    @post = Post.permalink(params[:post_id], admin?).first
    @comment = Comment.new(params[:comment].merge({ :post => @post, :personal_comment => admin? }))
    if @comment.save
      Mailer.comment_notifier(@comment).deliver unless @comment.personal_comment

      redirect_to "#{post_path(@post.permalink)}#commentinput", :notice => "Your comment was successfully submitted"
    else

      # TODO
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

      redirect_to "#{post_path(@post.permalink)}#commentinput", :alert => "Your comment submission failed due to some errors"
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    post = @comment.post
    @comment.destroy

    redirect_to "#{permalink_url(post.permalink)}#commentinput", :notice => "The comment was successfully deleted"
  end
end
