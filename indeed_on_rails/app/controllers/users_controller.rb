class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    fresh_start 

    @user = User.create(name: user_params[:name], location: user_params[:location])

    user_params[:languages].split(",").each do |lang|
      @language = Language.find_or_create_by(name: lang.strip.capitalize)
      @user.languages << @language
      Api.create_jobs(@user)
    end
    
    if @user.save
      redirect_to :controller => "jobs", :action => "index", :name => @user.name
    else
      render 'new'
    end
    
    Api.create_jobs(@user)
  end 

private

  def user_params
    params.require(:user).permit(:name, :location, :languages)
  end

  def fresh_start
    Job.delete_all
    Language.delete_all
    User.delete_all
    UserLanguage.delete_all
    JobLanguage.delete_all
  end

end
