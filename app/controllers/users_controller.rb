class UsersController < ApplicationController

  #ユーザー一覧
  def index
  	@users = User.all.order("id desc")
  end 

  #1ユーザー表示
  def show
  	@user = User.find(params[:id])
  end

  #新規ユーザー登録
  def new
    @user = User.new
  end
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Create User!"
      redirect_to @user
    else
      render 'new'
    end
  end

  #ユーザー編集
  def edit
  	@user = User.find(params[:id])
  end
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
       redirect_to user_path
    end
  end
  
  #ユーザー削除
  def destroy
    @user = User.find(params[:id])
    @user.destroy  
    redirect_to users_path
  end


  private
  
    def user_params
      params.require(:user).permit(:id, :name, :email)
    end
    
end

