class ClothingsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :edit, only: [:show, :edit, :update, :destroy, :confirm_destroy]

  def index
    if params[:category].blank?
      @top = @bottom = nil
      @no_results = true
      return
    end
  
    category = params[:category].to_s.downcase
  
    scope = user_signed_in? ?
      Clothing.where("user_id IS NULL OR user_id = ?", current_user.id) :
      Clothing.where(user_id: nil)
  
    scoped_category = scope.where("LOWER(category) = ?", category)
  
    @top = scoped_category.where("LOWER(article) = ?", "top").order("RANDOM()").first
    @bottom = scoped_category.where("LOWER(article) = ?", "bottom").order("RANDOM()").first
  
    @no_results = @top.nil? && @bottom.nil?
  end

  def catalog # display everything we got
    @clothings = Clothing.all
  end
  

  def show #one particular item
    @clothing = Clothing.find(params[:id]); 
  end

  def new #create new clothing item
    @clothing = Clothing.new
  end

  def create #confirm and save the creation
    @clothing = current_user.clothings.build(clothing_params)
    if @clothing.save
      redirect_to catalog_path, notice: "Clothing item was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit #edit existing clothing
    @clothing = Clothing.find(params[:id]); 
  end

  def update # helper to edit, confirm and save edit
    if @clothing.update(clothing_params)
      redirect_to catalog_path, notice: "Clothing item was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy # destroy and confirm 
    @clothing = Clothing.find(params[:id])
    @clothing.destroy
    redirect_to catalog_path, notice: 'Clothing item was successfully deleted.'
  end   

  private

  def clothing_params # define allowed parameters
    params.require(:clothing).permit(:name, :brand, :category, :article, :image)
  end
end
