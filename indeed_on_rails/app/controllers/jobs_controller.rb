class JobsController < ApplicationController

  def index
    @jobs = Job.all
    @name = params[:name]
  end
end
