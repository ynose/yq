class UsersController < ApplicationController

  def index
  	@users = User.all.order("user_id desc")
  end 

  def show
  	@user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
  	@user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
#     if @user.update_attributes(params[:user])
      redirect_to user_path
#     end
  end

  private
    def user_params
      params.require(:user).permit(:user_id, :name, :email)
    end
end

