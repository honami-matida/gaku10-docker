class Admin::HomesController < ApplicationController
  def top
    @posts = Post.all.page(params[:page]).per(9)
  end
end
