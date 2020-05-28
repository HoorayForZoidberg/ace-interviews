class UsersController < ApplicationController

  def index
    @users = User.where.not(id: current_user.id)
    @meeting = Meeting.new

  end

  def show
    @user = User.find(params[:id])
    @users = User.all
    @meetings = @user.meetings
    @meeting = Meeting.new
    @questions = Question.all
  end

end

