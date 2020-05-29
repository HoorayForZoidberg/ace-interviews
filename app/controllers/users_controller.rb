class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: :index

  def index
    if current_user.present?
      @users = User.where.not(id: current_user.id)
    else
      @users = User.all
    end

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
