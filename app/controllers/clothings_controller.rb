class ClothingsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_clothing, only: [:show, :edit, :update, :destroy, :confirm_destroy]

  def index
    if params[:category].blank?
      @top = @bottom = nil
      @no_results = true
      return
    end
  
    category = params[:category].to_s.downcase
  
    scope =
      if user_signed_in?
        if current_user.admin?
          # Admins only see general items
          Clothing.where(user_id: nil)
        else
          # Regular users see general + their own
          Clothing.where("user_id IS NULL OR user_id = ?", current_user.id)
        end
      else
        # Not signed in = general items only
        Clothing.where(user_id: nil)
      end
  
    scoped_category = scope.where("LOWER(category) = ?", category)
  
    @top = scoped_category.where("LOWER(article) = ?", "top").order("RANDOM()").first
    @bottom = scoped_category.where("LOWER(article) = ?", "bottom").order("RANDOM()").first
  
    @no_results = @top.nil? && @bottom.nil?
  end
    
  def catalog
    base_scope = if current_user&.admin?
      Clothing.where(user_id: nil)
    else
      Clothing
        .where("user_id IS NULL OR user_id = ?", current_user.id)
        .where.not(id: current_user.hidden_clothing_items.select(:id))
    end
  
    if params[:article].present?
      @clothings = base_scope.where("LOWER(article) = ?", params[:article].downcase)
    else
      @clothings = base_scope
    end
  
    @no_results = @clothings.empty?
  end

  def show #one particular item
    @clothing = Clothing.find(params[:id]); 
  end

  def new #create new clothing item
    @clothing = Clothing.new
  end

  def create #confirm and save the creation
    if current_user.admin?
      @clothing = Clothing.new(clothing_params)
    else
      @clothing = current_user.clothings.build(clothing_params)
    end

    if @clothing.save
      redirect_to catalog_path, notice: "Clothing item was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit #edit existing clothing
    @clothing = Clothing.find(params[:id]); 

    if @clothing.user_id.nil? || @clothing.user != current_user
      redirect_to catalog_path, alert: "You can't edit this item."
    end
  end

  def update
    @clothing = Clothing.find(params[:id])
    
    if @clothing.user_id.nil? || @clothing.user != current_user
      redirect_to catalog_path, alert: "You can't update this item."
      return
    end
  
    if @clothing.update(clothing_params)
      redirect_to catalog_path, notice: "Clothing item was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end
  

  def destroy
    @clothing = Clothing.find(params[:id])
  
    if @clothing.user_id.nil?
      # It's an admin item — hide it from the user instead of deleting
      if user_signed_in?
        current_user.hidden_clothing_items << @clothing unless current_user.hidden_clothing_items.include?(@clothing)
        redirect_to catalog_path, notice: "Clothing item hidden from your view."
      else
        redirect_to catalog_path, alert: "You must be signed in to hide items."
      end
    elsif @clothing.user == current_user || current_user.admin?
      # User-owned item or admin deleting
      @clothing.destroy
      redirect_to catalog_path, notice: "Clothing item was successfully deleted."
    else
      redirect_to catalog_path, alert: "You can't delete this item."
    end
  end    

  private
  def set_clothing #find clothing item by id
    @clothing = Clothing.find(params[:id])
  end

  def clothing_params # define allowed parameters
    params.require(:clothing).permit(:name, :brand, :category, :article, :image)
  end
end
