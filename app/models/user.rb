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

  def meetings
    Meeting.where('interviewee_id = :user_id OR interviewer_id = :user_id', user_id: id)
  end

  def is(interviewer, interviewee)
    if self == interviewer
      return interviewee
    else
       return interviewer
    end
  end
end
