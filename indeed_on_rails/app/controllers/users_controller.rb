class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    session[:user_info] = user_params

    Api.jobs_data(session[:user_info])

    redirect_to :controller => "jobs", :action => "index"
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
