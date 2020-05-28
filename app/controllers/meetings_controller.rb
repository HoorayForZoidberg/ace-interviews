class MeetingsController < ApplicationController
  before_action :find_meeting, only: [:show, :chat, :edit, :update, :destroy]
  
  def index
    @meetings = current_user.meetings
  end

  def new
    @meeting = Meeting.new
  end

  def create

    @meeting = Meeting.new(meeting_params)
    @meeting.interviewee = current_user
    @interviewer = User.find(params[:user_id])
    @meeting.interviewer = @interviewer
    @meeting.finished = false
    if @meeting.save
      redirect_to meeting_path(@meeting)
    else
      redirect_to users_path, alert: @meeting.errors.full_messages.to_sentence
    end
  end

  def show
    @review = Review.new
    @interviewee = @meeting.interviewee
    @interviewer = @meeting.interviewer
    @question = Question.find(@meeting.question_id) if @meeting.question_id?
    @other_user = current_user.is(@interviewer, @interviewee)

    return redirect_to root_path, notice: "This meeting has ended." if @meeting.finished?
    return redirect_to root_path, notice: "You cannot access this page." if current_user != @interviewer && current_user != @interviewee
  end

  def chat
    show
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
    params.require(:meeting).permit(:date, :question_id)
  end

  def find_meeting
    @meeting = Meeting.find(params[:id])
  end
end
