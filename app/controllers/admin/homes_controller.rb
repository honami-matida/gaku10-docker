class Admin::HomesController < ApplicationController
  def top
    @posts = Post.latest.page(params[:page]).per(9)
  end
end