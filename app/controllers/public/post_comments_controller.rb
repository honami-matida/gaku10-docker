class Public::PostCommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @post_comment = PostComment.new(post_comment_params)
    @post_comment.customer_id = current_customer.id
    @post_comment.post_id = @post.id
    if @post_comment.save
      @post_comments = @post.post_comments.order(created_at: :desc).page(params[:page]).per(9)
    else
      @post_comments = @post.post_comments.order(created_at: :desc).page(params[:page]).per(9)
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @post_comments = @post.post_comments.all.page(params[:page]).per(9).order(created_at: :desc)
    post_comment = PostComment.find(params[:id])
    post_comment.destroy

  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end
