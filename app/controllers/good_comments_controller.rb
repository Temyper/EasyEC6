class GoodCommentsController < ApplicationController
  
  before_action :authenticate_user!

  def create
    @good = Good.find(params[:good_id])
    @good_comment = GoodComment.new(good_comment_params)
    @good_comment.good_id = @good.id
    @good_comment.user_id = current_user.id
    unless @good_comment.save
      flash[:danger] = "投稿に失敗しました。"
      redirect_to good_path(@good)
    end
  end

  def destroy
    @good = Good.find(params[:good_id])
    good_comment = @good.good_comments.find(params[:id])
    good_comment.destroy
  end

  private

  def good_comment_params
    params.require(:good_comment).permit(:content)
  end
end
