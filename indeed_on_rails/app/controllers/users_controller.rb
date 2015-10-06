class UsersController < ApplicationController
  #Need to create form for new user and languages

  def new
    @user = User.new
  end
  
  def create
    @user = User.create(name: user_params[:name], location: user_params[:location])
    
    user_params[:languages].split(",").each do |lang| 
      @language = Language.find_or_create_by(name: lang.strip.capitalize)
      @user.languages << @language
    end
    
    if @user.save
      redirect_to @user
    else
      render 'new'
    end
  end 

private

  def user_params
    params.require(:user).permit(:name, :location, :languages)
  end

end
