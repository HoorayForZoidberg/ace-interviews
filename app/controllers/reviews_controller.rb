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
    raise
  end

  private

  def set_meeting
    @meeting = Meeting.find(params[:meeting_id])
  end

  def review_params
    params.require(:review).permit(:content, :readiness, :would_repeat, :polite_engaged, :structure, :math, :reasoning_originality, :communication, :confidence, :case_knowledge, :case_presentation, :accurate_feedback, :constructive_criticism, :level_adapted, :full_attention)
  end

end

