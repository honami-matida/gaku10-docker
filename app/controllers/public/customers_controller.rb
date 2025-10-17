class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!, only: [:index, :show, :edit, :favorites]
  before_action :ensure_current_customer, only: [:edit, :update]
  before_action :ensure_guest_customer, only: [:edit]

  def index
    @customers = Customer.all.page(params[:page]).per(9)
  end

  def show
    @customer = Customer.find(params[:id])
    @posts = @customer.posts.page(params[:page]).per(9).order(created_at: :desc)
  end

  def edit
    @customer = Customer.find(params[:id])

  end

  def update
    @customer = current_customer
    if @current_customer.update(customer_params)
      redirect_to profile_public_customer_path(@customer), notice: "保存しました"
    else
      flash.now[:alert] = "保存できません"
      render :edit
    end
  end

  def unsubscribe
    #会員の退会登録画面
  end

  def withdraw
    #会員の退会処理(ステータスの更新)
    @customer = Customer.find(current_customer.id)
    # is_deletedカラムをtrueに変更することにより削除フラグを立てる
    @customer.update(is_active: false)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to new_customer_registration_path
  end

  def favorites
    @customer = Customer.find(params[:id])
    favorites = Favorite.where(customer_id: @customer.id).pluck(:post_id)
    @favorite_posts = Post.where(id: favorites).page(params[:page]).per(9)
    @post = Post.find(params[:id])
  end

  private

  def authenticate_customer!
    unless customer_signed_in?
      flash[:alert] = "ログインが必要です。"
      redirect_to root_path
    end
  end

  def customer_params
    params.require(:customer).permit(:name, :email, :introduction, :profile_image)
  end

  def ensure_current_customer
    customer = Customer.find(params[:id])
    if current_customer != customer
      redirect_to public_customer_path(current_customer), alert: '他のユーザーのプロフィールを編集することはできません。'
    end
  end

  def ensure_guest_customer
    if current_customer.guest_customer?
      redirect_to public_customer_path(current_customer) , notice: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
    end
  end
end
