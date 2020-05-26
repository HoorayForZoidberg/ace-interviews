class ReviewsController < ApplicationController
  before_action :authenticate_user!, only: [ :user ]
  before_action :set_meeting, only: [ :new, :create ]

  def new
    @review = Review.new
  end

  def create
    @user = current_user
    @review = Review.new(review_params)
    @review.meeting = @meeting
    @review.user = current_user
    if @review.save
      redirect_to user_path(@user)
    else
      render :new
    end
  end

  private

  def set_meeting
    @meeting = Meeting.find(params[:meeting_id])
  end

  def review_params
    params.require(:review).permit(:content, :rating)
  end

end

