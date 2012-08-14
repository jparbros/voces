class Admin::CommentsController < Admin::BaseController

  def index
    @comments = Comment.all
    @spam_comments = Comment.unscoped.where(spam: true)
  end

  def check_spam
    @comment = Comment.find(params[:id])
    @comment.defensio_is_spam
  end

  def toggle_spam
    @comment = Comment.find(params[:id])
    if @comment.defensio_sig.nil?
      @comment.defensio_is_spam
      @comment.false_negative! unless @comment.spam?
    else
      @comment.false_negative!
    end
    redirect_to admin_comments_url
  end
end
