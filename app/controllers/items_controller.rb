class ItemsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_record_not_found

  def index
    if params[:user_id]
      user = User.find(params[:user_id])
      items = user.items
    else
    items = Item.all
    end
    render json: items, include: :user
  end

  def show
    item = Item.find(params[:id])
    render json: item
  end

  def create
    user = User.find(params[:user_id])
      if user
        user.items << Item.create(item_params)
        render json: user.items.last, status: :created
      else
      render json: {error: "item does not belowng to a user"}, status: :not_found
    end
  end

  private
  def item_params
    params.permit(:name, :description, :price)
  end

  def render_record_not_found
    render json: {error: "item not found"}, status: :not_found
  end

end
