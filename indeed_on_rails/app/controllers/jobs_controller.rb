class JobsController < ApplicationController

  def index
    @jobs = Job.all
    @name = params[:name]
    @user = User.find_by(name: @name)
  end
end
