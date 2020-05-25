class UsersController < ApplicationController

  def index
    @users = User.where.not(id: current_user.id)
  end

  def show
    @user = User.find(params[:id])
    @meetings = @user.meetings
    @reviews = @meetings.map(&:reviews).flatten.reject{ |review| review.user == @user }
  end


end
