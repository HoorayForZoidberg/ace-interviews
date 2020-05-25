class Meeting < ApplicationRecord
  belongs_to :interviewee, class_name:"User"
  belongs_to :interviewer, class_name:"User"

  validates :start_date, presence: true
end
