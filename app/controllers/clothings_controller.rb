class ClothingsController < ApplicationController
  def index
    if params[:category].present?
      @clothings = Clothing.where("category ILIKE ?", "%#{params[:category]}%")
    else
      @clothings = Clothing.all
    end
  end

  def new
    @clothing = Clothing.new
  end
  
  def create
    @clothing = Clothing.new(clothing_params)
    if @clothing.save
      redirect_to clothings_path, notice: "Clothing item added!"
    else
      render :new, status: :unprocessable_entity
    end
  end
  
  private
  
  def clothing_params
    params.require(:clothing).permit(:name, :brand, :category)
  end
  
end



