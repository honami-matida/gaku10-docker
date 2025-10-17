class Admin::CustomersController < ApplicationController
  def index
    @customers = Customer.all.page(params[:page]).per(9)
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def update
    customer = Customer.find(params[:id])
    if customer.update!(customer_params)
      flash[:notice] = "更新しました"
      redirect_to admin_customer_path(customer)
    else
      render :show
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :email, :introduction, :is_active, :profile_image)
  end
end
