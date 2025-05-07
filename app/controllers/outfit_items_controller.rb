class OutfitItemsController < ApplicationController
    def create
        @outfit = Outfit.find(params[:outfit_id])
        @clothing = Clothing.find(params[:clothing_id])
    
        if @outfit.clothing_items.exclude?(@clothing)
          @outfit.clothing_items << @clothing
          flash[:notice] = "Clothing item added to outfit."
        else
          flash[:alert] = "Clothing item is already in this outfit."
        end
    
        redirect_to outfit_path(@outfit)
    end
  
    def destroy
      outfit_item = OutfitItem.find(params[:id])
      outfit = outfit_item.outfit
      outfit_item.destroy
      redirect_to outfit
    end
  end
  