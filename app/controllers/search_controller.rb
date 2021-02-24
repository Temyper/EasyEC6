class SearchController < ApplicationController

  USER = "user"

  GOOD = "good"

  def search
    model = params["search"]["model"]
    content = params["search"]["content"]
    how = params["search"]["how"]

    @user = current_user
    @good = Good.new
    
    case(model)
      when GOOD
        @goods = search_for(how, model, content)
        # 20210224外部のコントローラのviewを呼び出す方法
        render template: "goods/index"
      when USER
        @users = search_for(how, model, content)
        render template:  "users/index"
    end
      
  end

  private

  def match(model, content)
    if model == USER
      User.where(name: content).page(params[:page]).reverse_order
    elsif model == GOOD
      Good.where(name: content).page(params[:page]).reverse_order
    end
  end

  def forward(model, content)
    if model == USER
      User.where("name LIKE ?", "#{content}%").page(params[:page]).reverse_order
    elsif model == GOOD
      Good.where("name LIKE ?", "#{content}%").page(params[:page]).reverse_order
    end
  end

  def backward(model, content)
    if model == USER
      User.where("name LIKE ?", "%#{content}").page(params[:page]).reverse_order
    elsif model == GOOD
      Good.where("name LIKE ?", "%#{content}").page(params[:page]).reverse_order
    end
  end

  def partical(model, content)
    if model == USER
      User.where("name LIKE ?", "%#{content}%").page(params[:page]).reverse_order
    elsif model == GOOD
      Good.where("name LIKE ?", "%#{content}%").page(params[:page]).reverse_order
    end
  end

  def search_for(how, model, content)
    # case文
    case how
    when "match"
      match(model, content)
    when "forward"
      forward(model, content)
    when "backward"
      backward(model, content)
    when "partical"
      partical(model, content)
    end
  end
end
