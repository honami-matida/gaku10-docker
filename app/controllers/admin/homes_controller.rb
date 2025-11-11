class Admin::HomesController < ApplicationController
  def top
    to  = Time.current.at_end_of_day
    from  = (to - 6.day).at_beginning_of_day
    
    @posts = Post.latest.page(params[:page]).per(9)
    if params[:latest]
      @posts = Post.latest.page(params[:page]).per(9)
    elsif params[:old]
      @posts = Post.old.page(params[:page]).per(9)
    elsif params[:favorite_count]
      posts = Post.all.sort {|a,b|
        b.favorites.where(created_at: from...to).size <=>
        a.favorites.where(created_at: from...to).size
      }
      @posts = Kaminari.paginate_array(posts).page(params[:page]).per(9)
    end

  
  end
end