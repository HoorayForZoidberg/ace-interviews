class MeetingsController < ApplicationController

def index
  @meetings = Meeting.all
end

def new
  #meeting has id / date / id_interviewer / id_question / id_interviewee / finished
  @meeting = Meeting.new
end

def create
  @meeting = Meeting.new(meeting_params)
  @meeting.id_interviewee = current_user
  @meeting.finished = false
  if @meeting.save
    redirect_to meeting_path(@meeting)
  else
    render :new
  end
end

def show
  @meeting = Meeting.new
end

def edit
end

def update
end

def destroy
  @meeting.destroy
  redirect_to index_path
end

private

def meeting_params
  params.require(:meeting).permit(:date, :id_interviewer, :id_question, :id_interviewee, :finished)
end

end
