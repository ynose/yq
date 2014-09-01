class VacationsController < ApplicationController

  def new
    @vacation = Vacation.new
    @vacation.user_id = params[:user_id]
  end

  def create
    @vacation = Vacation.new(vacation_params)
    if @vacation.save
      flash[:success] = "Create Vacation!"
      redirect_to params[:callback_url]
    else
      render 'new'
    end
  end


  def edit
  	@vacation = Vacation.find(params[:id])
  end

  def update
    @vacation = Vacation.find(params[:id])
    if @vacation.update_attributes(vacation_params)
      redirect_to params[:callback_url]
    end
  end


  def destroy
    @vacation = Vacation.find(params[:id])
    if @vacation.destroy  
      redirect_to params[:callback_url]
    end
  end

  private
    def vacation_params
      params.require(:vacation).permit(:user_id, :start_datetime, :end_datetime, :memo, :fixed)
    end
end
