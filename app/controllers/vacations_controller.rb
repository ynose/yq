class VacationsController < ApplicationController
  def index
  	@vacations = Vacation.all.order("user_id, start_datetime desc")
  end 

  def show
  	@vacation = Vacation.find(params[:id])
  end

  def new
    @vacation = Vacation.new
  end

  def create
    @vacation = Vacation.new(vacation_params)
    if @vacation.save
      flash[:success] = "Create Vacation!"
      redirect_to @vacation
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
      redirect_to vacation_path
    end
  end

  #ユーザー削除
  def destroy
    @vacation = Vacation.find(params[:id])
    @vacation.destroy  
    redirect_to vacations_path
  end

  private
    def vacation_params
      params.require(:vacation).permit(:user_id, :start_datetime, :end_datetime, :memo, :fixed)
    end
end
