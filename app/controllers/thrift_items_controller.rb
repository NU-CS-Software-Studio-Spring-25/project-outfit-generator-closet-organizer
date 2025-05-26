class ThriftItemsController < ApplicationController
  def index
    @thrift_items = ThriftItem.includes(:clothing, :user).all
  end

  def create
    clothing = Clothing.find(params[:thrift_item][:clothing_id])
    @thrift_item = ThriftItem.new(
      clothing: clothing,
      user: current_user,
      price: params[:thrift_item][:price]
    )
  
    if @thrift_item.save
      redirect_to thrift_items_path, notice: "Item listed for thrift!"
    else
      redirect_to catalog_path, alert: "Something went wrong."
    end
  end
  

  def new
    @clothing = Clothing.find(params[:clothing_id])
    @thrift_item = ThriftItem.new
  
    unless @clothing
      redirect_to catalog_path, alert: "Clothing item not found."
    end
  end
end
