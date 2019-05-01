class CatsController < ApplicationController
  def index
    @cats = Cat.all
    render :index
  end

  def show
    @show_cat = Cat.find(params[:id])

    render :show
  end

  def new
    @cat = Cat.new

    render :new
  end

  def create
    @cat = Cat.new(cat_params)

    if @cat.save
      redirect_to cats_url
    else
      render :new
    end
  end

  private

  def cat_params
    params.require(:cat).permit(:name, :birth_date, :color, :description, :sex)
  end
end
