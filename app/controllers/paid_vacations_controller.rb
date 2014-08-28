class PaidVacationsController < ApplicationController
  def index
  	@paid_vacations = PaidVacation.all.order("year desc")
  end 

  def show
  	@paid_vacation = PaidVacation.find(params[:id])
  end

  def new
    @paid_vacation = PaidVacation.new
  end

  def create
    @paid_vacation = PaidVacation.new(paid_vacation_params)
    if @paid_vacation.save
      flash[:success] = "Create Paid Vacation!"
      redirect_to @paid_vacation
    else
      render 'new'
    end
  end

  def edit
  	@paid_vacation = PaidVacation.find(params[:id])
  end

  def update
    @paid_vacation = PaidVacation.find(params[:id])
    if @paid_vacation.update_attributes(paid_vacation_params)
      redirect_to paid_vacation_path
    end
  end

  #ユーザー削除
  def destroy
    @paid_vacation = PaidVacation.find(params[:id])
    @paid_vacation.destroy  
    redirect_to paid_vacations_path
  end

  private
    def paid_vacation_params
      params.require(:paid_vacation).permit(:user_id, :year, :hours, :carryover_hours)
    end
end
