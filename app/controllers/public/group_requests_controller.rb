class Public::GroupRequestsController < ApplicationController
  before_action :authenticate_customer!
  before_action :ensure_group_owner, only: [:update]
  before_action :ensure_member, only: [:destroy] # メンバー確認のフィルター追加

  def create
    @group = Group.find(params[:group_id])
    @group_request = @group.group_requests.new(customer: current_customer, is_status: :pending)
    if @group_request.save
      flash[:notice] = "申請が送信されました"
      redirect_to public_group_path(@group)
    else
      flash[:alert] = "申請に失敗しました"
      redirect_to public_group_path(@group)
    end
  end

  def update
    @group_request = GroupRequest.find(params[:id])

    if params[:is_status] == 'approved'
      @group_request.update(is_status: 1)
      flash[:notice] = "申請を承認しました"
    elsif params[:is_status] == 'rejected'
      @group_request.update(is_status: 2)
      flash[:notice] = "申請を拒否しました"
    end

    redirect_to public_group_path(@group_request.group)
  end

  def destroy
    @group = Group.find(params[:group_id])
    @group_request = @group.group_requests.find_by(customer: current_customer, is_status: [:approved])

    if @group_request
      @group_request.destroy
      flash[:notice] = "グループから退会しました"
    else
      flash[:alert] = "退会に失敗しました"
    end

    redirect_to public_groups_path
  end

  private

  def group_request_params
    params.require(:group_request).permit(:is_status)
  end

  def ensure_group_owner
    @group_request = GroupRequest.find(params[:id])
    @group = @group_request.group  # グループを申請から取得
    unless @group.owner_id == current_customer.id
      redirect_to public_group_path(@group), alert: "権限がありません"
    end
  end

  def ensure_member
    @group = Group.find(params[:group_id])
    unless @group.customers.include?(current_customer)
      redirect_to public_groups_path, alert: "グループメンバーではありません"
    end
  end

end