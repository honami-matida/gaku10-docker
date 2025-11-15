class Admin::SearchesController < ApplicationController
  before_action :authenticate_admin!

  def search
    @word = params[:word]
    @model = params[:model]

    case @model
    when "post"
      @posts = Post.where("title LIKE ? OR introduction LIKE ?", "%#{@word}%", "%#{@word}%")
                  .includes(:customer)

    when "customer"
      @customers = Customer.where("name LIKE ? OR email LIKE ?", "%#{@word}%", "%#{@word}%")
    when "comment"
      @comments = PostComment.where("comment LIKE ?", "%#{@word}%")
                             .includes(:customer, :post)
    end
  end
end
