class BookingsController < ApplicationController
  before_action :authorize, only: [:new, :create]


  #need to declare @listing_for_booking and @booking because the url have 2 objects which are, /listings and /bookings
  def new                
    @list_for_booking = Listing.all.find(params[:listing_id])
    @booking = Booking.new
  end


  def create
    @booking = current_user.bookings.new(booking_params)
    @booking.listing_id = params[:listing_id]      # this line of code is to insert listing id value into listing_id column

    if @booking.save 
      redirect_to [@booking.listing, @booking], notice: "Booking successfully made"
      # Alternative way of writing ------> redirect_to listing_booking_path(@booking.listing_id, @booking), notice: "Booking successfully made"
    else
      redirect_to listings_path, notice: "Booking failed"
    end

  end


  def show 
    @bookings = Booking.all.find(params[:id])
  end



  private

  def booking_params
    params.require(:booking).permit(:date, :start_time, :end_time)
  end

end