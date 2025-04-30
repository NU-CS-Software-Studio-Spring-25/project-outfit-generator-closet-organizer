class ClothingsController < ApplicationController
  def index
    if params[:category].present?
      @clothings = Clothing.where("category ILIKE ?", "%#{params[:category]}%")
    else
      @clothings = Clothing.all
    end
  end
end
