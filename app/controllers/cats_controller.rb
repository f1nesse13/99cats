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
  end

  def create
  end
end
