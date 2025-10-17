class Admin::PostCommentsController < ApplicationController
  def index
    @post_comments = PostComment.all.page(params[:page]).per(9).order(created_at: :desc)
  end

  def show
    @post_comment = PostComment.find(params[:id])
  end

  def destroy
    post_comment = PostComment.find(params[:id])
    post_comment.destroy
    flash[:notice] = "コメントを削除しました"
    redirect_to admin_post_comments_path
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end

end
