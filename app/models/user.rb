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
end
