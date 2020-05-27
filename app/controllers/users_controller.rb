class UsersController < ApplicationController

  def index
    @users = User.where.not(id: current_user.id)
    @meeting = Meeting.new
  end

  def show
    @user = User.find(params[:id])
    return redirect_to root_path, notice: "you can't access this page" if current_user != @user
    @meetings = @user.meetings
  end

end

