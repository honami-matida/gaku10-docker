class Public::PostCommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @post_comments = @post.post_comments.all.page(params[:page]).per(9).order(created_at: :desc)
    @post_comment = PostComment.new(post_comment_params)
    @post_comment.customer_id = current_customer.id
    @post_comment.post_id = @post.id
    if @post_comment.save

    else
      @post_comments = @post.post_comments.all.page(params[:page]).per(9).order(created_at: :desc)
      flash.now[:notice] = "送信に失敗しました"
      render 'public/posts/show'
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @post_comments = @post.post_comments.all.page(params[:page]).per(9).order(created_at: :desc)
    post_comment = PostComment.find(params[:id])
    post_comment.destroy
    flash[:notice] = "コメントを削除しました"

  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end
