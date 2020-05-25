class MeetingsController < ApplicationController

def meetings
  @meetings = Meeting.all
end

def new
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
  @meeting = Meeting.find(params[:id])
  @review = Review.new
end

def edit
  @meeting = Meeting.new
end

def update
  if @meeting.update(meeting_params)
    redirect_to meeting_path(@meeting)
  else
    render :edit
  end
end

def destroy
  @meeting = Meeting.find(params[:id])
  @meeting.destroy
  redirect_to index_path
end

private

def meeting_params
  params.require(:meeting).permit(:date, :id_interviewer, :id_question)
end

end
