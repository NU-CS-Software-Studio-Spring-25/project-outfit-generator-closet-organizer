class ClothingsController < ApplicationController
  before_action :set_clothing, only: [:show, :edit, :update, :destroy, :confirm_destroy]

  def index
    if params[:category].present?
      if user_signed_in?
        @clothings = Clothing.where("category ILIKE ?", "%#{params[:category]}%").where("user_id IS NULL OR user_id = ?", current_user.id)
      else
        @clothings = Clothing.where("category ILIKE ?", "%#{params[:category]}%").where(user_id: nil)
      end
    else
      if user_signed_in?
        @clothings = Clothing.where("user_id IS NULL OR user_id = ?", current_user.id)
      else
        @clothings = Clothing.where(user_id: nil)
      end
    end
    
    @no_results = @clothings.empty?
  end

  def show
    @clothing = Clothing.find(params[:id]); 
  end

  def new
    @clothing = Clothing.new
  end

  def create
    @clothing = current_user.clothings.build(clothing_params)
    if @clothing.save
      redirect_to clothings_path, notice: "Clothing item was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @clothing = Clothing.find(params[:id]); 
  end

  def update
    if @clothing.update(clothing_params)
      redirect_to clothings_path, notice: "Clothing item was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @clothing = Clothing.find(params[:id])
    @clothing.destroy
    redirect_to clothings_path, notice: 'Clothing item was successfully deleted.'
  end   

  private

  def set_clothing
    @clothing = Clothing.find(params[:id])
  end

  def clothing_params
    params.require(:clothing).permit(:name, :brand, :category, :image)
  end
end
