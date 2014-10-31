class Admin::UsersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :is_admin

  def index
    @users = paginator(User.all)
  end

  def new
    @user = User.new
    @roles = Role.all
  end

  def create
    @user = User.new(user_params)
    if @user.valid?
      if @user.save
        redirect_to admin_users_path
      else
        flash[:error] = 'Not save'
        redirect_to :back
      end
    else
      flash[:error] = get_errors(@user.errors.messages)
      redirect_to :back
    end
  end

  def edit
    @user = User.find(params[:id])
    @roles = Role.all
  end

  def update
    @user = User.find(params[:id])
    @user.update_attributes(user_params.except(:password, :email, :password_confirmation))
    if @user.valid?
      if @user.save
        flash[:success] = t(:success_update)
        redirect_to admin_users_path
      else
        flash[:error] = 'Not save'
        redirect_to :back
      end
    else
      flash[:error] = get_errors(@user.errors.messages)
      redirect_to :back
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :role_id)
  end

end
