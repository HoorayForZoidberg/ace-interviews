class ReviewsController < ApplicationController
  before_action :authenticate_user!, only: [ :user ]


#  def show
#    @review
#  end

 # def index
 #   @reviews = Review.all
    #filter it by current user

  #end

  def new
    @meeting = Meeting.find(params[:meeting_id])
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @meeting = Meeting.find(params[:meeting_id])
    @review.meeting = @meeting
    if @review.save
      redirect_to user_path(@user)
    else
      render :new
    end
  end

  private

  def review_params
    params.require(:review).permit(:content, :rating)
  end

end

