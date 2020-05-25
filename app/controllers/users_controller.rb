class UsersController < ApplicationController

  def index
    @users = User.where.not(id: current_user.id)
  end

  def show
    @user = User.find(params[:id])
    @meetings = @user.meetings
    @reviews = @meetings.reviews if @meetings.reviews.user != @user
  end


end
