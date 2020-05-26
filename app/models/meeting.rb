class Meeting < ApplicationRecord
  belongs_to :interviewee, class_name:"User"
  belongs_to :interviewer, class_name:"User"
  has_one :question

  validates :date, presence: true
  validate :date_cannot_be_in_the_past

  def date_cannot_be_in_the_past
    if date.present? && date < Date.today
      errors.add(:date, "can't be in the past")
    end
  end
end
