class ClothingsController < ApplicationController
    def index
      @clothings = Clothing.all
    end
  end
  