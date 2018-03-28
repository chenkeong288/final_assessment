class ListingsController < ApplicationController

  def index
    @listings = Listing.order(updated_at: :asc)
  end


  def new 
    if signed_in? 
      @listing = Listing.new
    else 
      redirect_to listings_path, notice: "Please Sign In to sell a car"
    end 
  end 


  def create
    @listing = current_user.listings.new(listing_params) 

    if @listing.save 
      redirect_to @listing  #show - require show method to be defined 
    else 
      redirect_to new_listing_path
    end
  end


  def show 
    @listing_for_show = Listing.all.find(params[:id])
  end


  #Delete - Alternative way to write delete is in AirBnb code
  def destroy
    @listing_to_delete = current_user.listings.find(params[:id])
    @listing_to_delete.delete

    redirect_to listings_path
  end 


  def edit
    @listing_to_edit = current_user.listings.find(params[:id])
  end


  def update
    @listing_to_update = current_user.listings.find(params[:id])

    @listing_to_update.update_attributes(listing_params)

    if @listing_to_update.save
      redirect_to listings_path, notice: "Listing successfully updated"
    else
      redirect_to listings_path, notice: "Edit failed"
    end
  end


  def search
    @listings = Listing.all

    search_params(params).each do |key, value|
      @listings = @listings.public_send(key, value) if value.present?
    end 

    respond_to do |format|
        format.js
    end

  end



  private 

  def listing_params
    params.require(:listing).permit(:car_brand, :car_model, :description, :location_of_seller, :price)
  end

  def search_params(params)
    params.slice(:car_brand, :car_model)
  end

end
