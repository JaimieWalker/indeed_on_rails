class SearchController < ApplicationController
  def new
      @languages = params[:user][:languages]
      @user = params[:user]
      @location = params[:user][:location]
      @name = params[:user][:name]
  end

  def results
    Api.call
    #list jobs 
  end

end
