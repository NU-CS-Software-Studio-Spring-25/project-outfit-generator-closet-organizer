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
  # Handle filters
  view_filter = params[:view] || "all"
  article_filter = params[:article]
  category_filter = params[:category]

  scope = if current_user
            Clothing.where("user_id IS NULL OR user_id = ?", current_user.id)
          else
            Clothing.where(user_id: nil)
          end

  if view_filter == "admin"
    scope = scope.where(user_id: nil)
  elsif view_filter == "user" && current_user
    scope = scope.where(user_id: current_user.id)
  elsif view_filter == "all" && current_user
    scope = scope.where.not(id: current_user.hidden_clothing_items.select(:id))
  end

  if article_filter.present?
    scope = scope.where("LOWER(article) = ?", article_filter.downcase)
  end

  if category_filter.present?
    scope = scope.where("LOWER(category) = ?", category_filter.downcase)
  end

  @clothings = scope.order(created_at: :desc).page(params[:page])
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

  def edit
    @clothing = Clothing.find(params[:id])
  
    if current_user.admin?
      # Admins can edit anything
      return
    elsif @clothing.user != current_user
      redirect_to catalog_path, alert: "You can't edit this item."
    end
  end  

  def update
    @clothing = Clothing.find(params[:id])

    unless current_user.admin? || @clothing.user == current_user
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
      if current_user.admin?
        # Admin deleting a public item — delete it fully
        @clothing.destroy
        redirect_to catalog_path, notice: "Admin item successfully deleted."
      elsif user_signed_in?
        # Regular user — soft hide from this user's view
        current_user.hidden_clothing_items << @clothing unless current_user.hidden_clothing_items.include?(@clothing)
        redirect_to catalog_path, notice: "Item hidden from your view."
      else
        redirect_to catalog_path, alert: "You must be signed in to hide items."
      end
    elsif @clothing.user == current_user || current_user.admin?
      @clothing.destroy
      redirect_to catalog_path, notice: "Item successfully deleted."
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
