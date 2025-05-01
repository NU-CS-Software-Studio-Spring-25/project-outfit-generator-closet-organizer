class ClothingsController < ApplicationController
  before_action :set_clothing, only: %i[show edit update destroy]

  def index
    if params[:category].present?
      @clothings = Clothing.where(category: params[:category].downcase)
    else
      @clothings = Clothing.all
    end
  end

  def show
    @clothing = Clothing.find(params[:id]); 
  end

  def new
    @clothing = Clothing.new
  end

  def create
    @clothing = Clothing.new(clothing_params)
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
<<<<<<< HEAD
    redirect_to clothings_path, notice: "Clothing item deleted."
=======
    redirect_to clothing_index_path, notice: 'Clothing item was successfully deleted.'
>>>>>>> 54e69caeef0c6da5f1415c4be2fb1931b336817a
  end

  private

  def set_clothing
    @clothing = Clothing.find(params[:id])
  end

  def clothing_params
    params.require(:clothing).permit(:name, :brand, :category, :image)
  end
end
