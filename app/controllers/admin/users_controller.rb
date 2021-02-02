class Admin::UsersController < Admin::ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  def index
    @users = User.includes(:role).order(created_at: :desc).all
  end

  # GET /users/1
  def show
  end

  # GET /users/1/edit
  def edit
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      redirect_to url_for(action: 'show', id: @user), notice: f(@user)
    else
      render :edit
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
    redirect_to url_for(action: 'index'), notice: f(@user)
  end

private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email)
  end
end
