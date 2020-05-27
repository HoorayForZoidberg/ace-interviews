class UsersController < ApplicationController

  def index
    @users = User.where.not(id: current_user.id)

  end

  def show
    @user = User.find(params[:id])
    @meetings = @user.meetings
    @meetings_as_applicant = @meetings.where(interviewee_id: @user.id)
    @meetings_as_interviewer = @meetings.where(interviewer_id: @user.id)
    @reviews = @meetings.map(&:reviews).flatten.reject{ |review| review.user == @user }
    @reviews_as_applicant = @meetings_as_applicant.map(&:reviews).flatten.reject { |review| review.user == @user }

  end


end
