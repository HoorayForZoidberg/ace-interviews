class MeetingsController < ApplicationController
  before_action :find_meeting, only: [:show, :edit, :update, :destroy]
  def index
    @meetings = current_user.meetings
  end

  def new
    @meeting = Meeting.new
  end

  def create

    @meeting = Meeting.new(meeting_params)
    @meeting.interviewee_id = current_user.id
    @meeting.finished = false
    if @meeting.save
      redirect_to meeting_path(@meeting)
    else
      render :new
    end
  end

  def show
    @review = Review.new
  end

  def edit; end

  def update
    if @meeting.update(meeting_params)
      redirect_to meeting_path(@meeting)
    else
      render :edit
    end
  end

  def destroy
    @meeting.destroy
    redirect_to meetings_path
  end

private

  def meeting_params
    params.require(:meeting).permit(:date, :interviewer_id, :question_id)
  end

  def find_meeting
    @meeting = Meeting.find(params[:id])
  end

end
