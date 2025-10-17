class Public::GenresController < ApplicationController
  before_action :authenticate_customer!, only: [:index, :show]

  def index
    @genres = Genre.all
  end

  def show
    @genre = Genre.find(params[:id])
    @posts = @genre.posts.page(params[:page]).per(9)
  end

  private

  def genre_params
    params.require(:genre).permit(:name, :introduction)
  end

  def authenticate_customer!
    unless customer_signed_in?
      flash[:alert] = "ログインが必要です。"
      redirect_to root_path
    end
  end
end
