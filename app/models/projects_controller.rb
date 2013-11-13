class ProjectsController < ApplicationController
  def create
    @item = Item.new(params[:item])
    if @item.save
      redirect_to action: "index"
    else
      render "new"
    end
  end
end