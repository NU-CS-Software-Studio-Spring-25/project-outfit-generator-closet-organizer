class OutfitsController < ApplicationController
    before_action :authenticate_user! # Ensure the user is logged in
    before_action :set_outfit, only: [:edit, :update, :show, :destroy]
  
    def index
      @outfits = current_user.outfits
    end
    
    def show
        @outfit = current_user.outfits.find(params[:id])
        @clothing_items = @outfit.clothing_items
        @clothing = Clothing.new
        @outfit_item = OutfitItem.new
    end 

    def new
      @outfit = Outfit.new
      @clothing_id = params[:clothing_id]
    end
  
    def create
      @outfit = current_user.outfits.build(outfit_params)
      if @outfit.save
        if params[:clothing_id].present?
          clothing = Clothing.find(params[:clothing_id])
          @outfit.outfit_items.create(clothing: clothing) if clothing
        end
        redirect_to @outfit, notice: "Outfit created successfully."
      else
        render :new
      end
    end

    def edit
    end
  
    def add_item
        clothing = Clothing.find(params[:clothing_id])
    
        # Ensure the outfit does not already contain the clothing item
        unless @outfit.clothings.include?(clothing)
          @outfit.outfit_items.create(clothing: clothing)  # This creates the OutfitItem
        end
    
        redirect_to @outfit, notice: "#{clothing.name} has been added to your outfit."
    end

    def update
        if @outfit.update(outfit_params)
          flash[:notice] = "Outfit updated successfully!"
          redirect_to outfit_path(@outfit)
        else
          render :edit
        end
    end

    def destroy
        @outfit = Outfit.find(params[:id])
        @outfit.destroy
        redirect_to outfits_path, notice: "Outfit was successfully deleted."
    end

    def confirm_destroy
        @outfit = Outfit.find(params[:id])
    end
  
    private
  
    def set_outfit
      @outfit = current_user.outfits.find(params[:id])
    end
  
    def outfit_params
      params.require(:outfit).permit(:name, :description, :image)
    end
  end
  
