class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :users_as_interviewee,
         foreign_key: :interviewee_id,
         class_name: :Meeting
  has_many :users_as_interviewer,
         foreign_key: :interviewer_id,
         class_name: :Meeting
  belongs_to :university
  has_one_attached :avatar
  validates :first_name, :last_name, :email, :address, presence: true

  def is(interviewer, interviewee)
    self == interviewer ? interviewee : interviewer
  end

  def meetings
    Meeting.where('interviewee_id = :user_id OR interviewer_id = :user_id', user_id: id)
  end
  def meetings_as_interviewee(attributes = {})
    all_meetings = Meeting.where(interviewee_id: id)
    if attributes[:past].present?
      all_meetings = all_meetings.where("date < ?", Time.now).where(finished: true)
    elsif attributes[:future].present?
      all_meetings = all_meetings.where("date > ?", Time.now).where(finished: false)
    end
    return all_meetings
  end

  def meetings_as_interviewer(attributes = {})
    all_meetings = Meeting.where(interviewer_id: id)
    if attributes[:past].present?
      all_meetings = all_meetings.where("date < ?", Time.now).where(finished: true)
    elsif attributes[:future].present?
      all_meetings = all_meetings.where("date > ?", Time.now).where(finished: false)
    end
    return all_meetings
  end

  def reviews_as_interviewee(attributes = {})
    meetings_as_interviewee(past: true).map(&:reviews)
                           .flatten
                           .reject { |review| review.user == self }
  end
  def rating_as_interviewee(attributes = {})
    reviews = reviews_as_interviewee(past: true).map(&:rating)
    return 0 if reviews.empty?
    reviews.sum.fdiv(reviews.size)
  end
  def reviews_as_interviewer(attributes = {})
    meetings_as_interviewer(past: true).map(&:reviews)
                           .flatten
                           .reject { |review| review.user == self }
  end
  def rating_as_interviewer(attributes = {})
    reviews = reviews_as_interviewer(past: true).map(&:rating)
    return 0 if reviews.empty?
    reviews.sum.fdiv(reviews.size)
  end

end
