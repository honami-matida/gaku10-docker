class Public::FavoritesController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @post_favorite = current_customer.favorites.new(post_id: @post.id)
    @post_favorite.save

  end

  def destroy
    @post = Post.find(params[:post_id])
    @post_favorite = current_customer.favorites.find_by(post_id: @post.id)
    @post_favorite.destroy

  end

end
