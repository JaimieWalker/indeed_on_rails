class UsersController < ApplicationController
  #Need to create form for new user and languages

  def new
    @user = User.new
  end
  
  def create
    # byebug
    @user = User.create(user_params)
    if @user.save
      redirect_to @user
    else
      render 'new'
    end
  end 

private

  def user_params
    params.require(:user).permit(:name,:location,:languages => [])
  end

end
