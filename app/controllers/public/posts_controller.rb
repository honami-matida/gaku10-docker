class Public::PostsController < ApplicationController
  before_action :ensure_guest_customer, only: [:new]
  before_action :authenticate_customer!, only: [:new, :index, :show, :edit]
  before_action :is_matching_login_customer, only: [:edit, :update]

  def new
    @post = Post.new
    @genre = params[:genres]
  end

  def create
    @post = Post.new(post_params)
    @post.customer_id = current_customer.id
    tags = Vision.get_image_data(post_params[:images].first) # 画像ファイルを取得（配列から最初のファイルを使用）
    if @post.save
      tags.each do |tag|
        @post.tags.create(name: tag)
      end
      redirect_to public_post_path(@post)
    else
      flash.now[:notice] = "投稿に失敗しました"
      render :new
    end

  end

  def index
    to  = Time.current.at_end_of_day
    from  = (to - 6.day).at_beginning_of_day
    @posts = Post.all.page(params[:page]).per(9)
    if params[:latest]
      @posts = Post.latest.page(params[:page]).per(9)
    elsif params[:old]
      @posts = Post.old.page(params[:page]).per(9)
    else
      to  = Time.current.at_end_of_day
      from  = (to - 6.day).at_beginning_of_day
      @posts = Post.all.sort {|a,b|
        b.favorites.where(created_at: from...to).size <=>
        a.favorites.where(created_at: from...to).size
      }
      @posts = Kaminari.paginate_array(@posts).page(params[:page]).per(9)
    end
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
    @post_comments = @post.post_comments.all.page(params[:page]).per(9).order(created_at: :desc)
  end

  def edit
    @post = Post.find(params[:id])
    @genre = params[:genres]

  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to public_post_path(@post), notice:"更新されました"
    else
      flash.now[:notice] = "更新に失敗しました"
      render :edit
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to profile_public_customer_path(post.customer), notice:"投稿を削除しました"
  end

  private

  def post_params
    params.require(:post).permit(:title, :introduction, :genre_id, images: [])
  end

  def authenticate_customer!
    unless customer_signed_in?
      flash[:alert] = "ログインが必要です。"
      redirect_to root_path
    end
  end

  def is_matching_login_customer
    @post = Post.find(params[:id])
    customer = @post.customer
    unless customer.id == current_customer.id
      flash[:alert] = "投稿した会員でないので編集できません。"
      redirect_to root_path
    end
  end

  def ensure_guest_customer

    if customer_signed_in? && current_customer.guest_customer?
      redirect_to public_customer_path(current_customer) , notice: "ゲストユーザーは新規投稿画面へ遷移できません。"
    end
  end

end
