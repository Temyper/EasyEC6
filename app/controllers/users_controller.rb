require "csv"

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

  def output_my_goods
    goods = Good.where(user_id: current_user.id)
    
    # 20210223形式毎に処理を分ける文法
    respond_to do |format|
      format.html
      format.csv do |csv|
        my_goods_csv = csv_data(goods)
        send_data(my_goods_csv, filename: "MyGoods.csv")
      end
    end
  end



  private

  def user_params
    params.require(:user).permit(:name,:email,:introduction, :profile_image)
  end
  
  def csv_data(datas)
    
    made_csv  = CSV.generate do |csv|
    
      # %w……コード上、「,」の代わりに空白区切りで記述する
      header = %w(name introduction value)
      
      csv << header
      
      datas.each do |data|
        
        csv << [data.name, data.introduction, data.value]
        
      end
      
    end
    
    return made_csv
    
  end
end
