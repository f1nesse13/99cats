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

  def approve
    @crr = CatRentalRequest.find(params[:rental_id])
    @cat = Cat.find(params[:id])
    if @crr.approve!
      redirect_to cat_url(@cat)
    else
      redirect_to cat_url(@cat)
    end
  end

  def deny
    @crr = CatRentalRequest.find(params[:rental_id])
    @cat = Cat.find(params[:id])
    if @crr.deny!
      redirect_to cat_url(@cat)
    else
      redirect_to cat_url(@cat)
    end
  end

  def cat_rental_request_params
    params.require(:cat_rental_request).permit(:cat_id, :start_date, :end_date)
  end
end
