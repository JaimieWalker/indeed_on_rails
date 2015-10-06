class SearchController < ApplicationController
  def new
      @languages = params[:user][:languages].split(",")
      @user = params[:user]
      @location = params[:user][:location]
      @name = params[:user][:name]
  end

  def results

  end

end
