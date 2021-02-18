class UsersController < ApplicationController
  def show
    @user  = User.find(params[:id])
    @goods = @user.goods.page(params[:page]).reverse_order
    @good = Good.new
  end

  def index
    @user = current_user
    @users = User.page(params[:name]).reverse_order
    @good = Good.new
  end

  def edit
    @user = User.find(params[:id])
    if @user == current_user
      render "edit"
    else
      redirect_to user_path(current_user)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "更新に成功しました。"
      redirect_to user_path(@user.id)
    else
      render 'edit'
    end

  end

  private

  def user_params
    params.require(:user).permit(:name,:email,:introduction, :profile_image)
  end
end
