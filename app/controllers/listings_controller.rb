class ListingsController < ApplicationController
  before_action :authorize, only: [:new, :create, :destroy, :edit]

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


  def destroy

    @listing_to_delete = Listing.find(params[:id])

    if @listing_to_delete.user_id == current_user.id

      @listing_to_delete.destroy

      redirect_to listings_path

    else 

      redirect_to listings_path, notice: "Only owner of the car is eligible to delete!"
  
    end

  end 


  def edit

    @listing_to_edit = Listing.find(params[:id])

    if @listing_to_edit.user_id == current_user.id

      render 'edit'

    else

       redirect_to listings_path, notice: "Only owner of the car is eligible to edit!"

    end

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
