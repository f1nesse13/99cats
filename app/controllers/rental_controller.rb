class RentalController < ApplicationController
  def new
    @crr = CatRentalRequest.new
    @cats = Cat.all

    render :new
  end

  def create
    @crr = CatRentalRequest.new(cat_rental_request_params)
    @cats = Cat.all
    if @crr.save
      redirect_to cats_url
    else
      render :new
    end
  end

  def cat_rental_request_params
    params.require(:cat_rental_request).permit(:cat_id, :start_date, :end_date)
  end
end
