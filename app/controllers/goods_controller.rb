class GoodsController < ApplicationController
  def new
    @good = Good.new
  end

  def create
    @good = Good.new(good_params)
    @good.user_id = current_user.id
    
    if @good.save
      flash[:success] = '更新に成功しました。'
      redirect_to good_path(@good)
    else
      @goods = Good.page(params[:page]).reverse_order
      @user = current_user
      render "index"
    end

  end

  def index
    @goods = Good.page(params[:page]).reverse_order
    @user = current_user
    @good = Good.new
  end

  def show
    @good = Good.find(params[:id])
    @good_new = Good.new
    @user = @good.user
    @good_comment = GoodComment.new
  end

  def destroy
    @good = Good.find(params[:id])
    @good.destroy
    redirect_to goods_path
  end

  def edit
    @good = Good.find(params[:id])
    if @good.user == current_user
    render "edit"
    else
      redirect_to goods_path
    end
  end

  def update
    @good = Good.find(params[:id])
    if @good.update(good_params)
      flash[:success] = "更新に成功しました。"
      redirect_to good_path(@good.id)
    else
      render 'edit'
    end
  end

  private

  def good_params
    params.require(:good).permit(:name, :introduction,:user_id ,:image, :value)
  end
end
