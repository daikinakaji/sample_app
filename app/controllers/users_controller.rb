class UsersController < ApplicationController
  before_action:logged_in_user,only:[:edit,:update]
  before_action:correct_user,only:[:edit,:update]
  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    #code
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "welcom to the sample app"
      redirect_to @user
    else
      render "new"
    end
  end

  def edit
    @user = User.find(params[:id])
    #code
  end

  def update
    @user = User.find(params[:id])
  if @user.update_attributes(user_params)
    flash[:success] ="profile updated"
    redirect_to @user
  else
    render "edit"

  end
  end

  private

    def user_params
      params.require(:user).permit(:name,:email,:password,:password_confirmation)
     #code
    end

    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "please log in"
        redirect_to login_url

      end
      #code
    end
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(user)
    end
end