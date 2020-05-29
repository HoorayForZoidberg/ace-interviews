class Review < ApplicationRecord
  belongs_to :meeting
  belongs_to :user

    #general validation
    validates :would_repeat, presence: true
    validates :polite_engaged, presence: true

    validates :structure,inclusion: { in: 1..5 }, if: :is_applicant?
    validates :math,inclusion: { in: 1..5 }, if: :is_applicant?
    validates :reasoning_originality,inclusion: { in: 1..5 }, if: :is_applicant?
    validates :communication,inclusion: { in: 1..5 }, if: :is_applicant?
    validates :confidence,inclusion: { in: 1..5 }, if: :is_applicant?
    validates :readiness,inclusion: { in: 1..5 }, if: :is_applicant?

    validates :case_knowledge,inclusion: { in: 1..5 }, if: :not_applicant?
    validates :case_presentation,inclusion: { in: 1..5 }, if: :not_applicant?
    validates :accurate_feedback,inclusion: { in: 1..5 }, if: :not_applicant?
    validates :constructive_criticism,inclusion: { in: 1..5 }, if: :not_applicant?
    validates :level_adapted,inclusion: { in: 1..5 }, if: :not_applicant?
    validates :full_attention,inclusion: { in: 1..5 }, if: :not_applicant?

    def is_applicant?
      self.user == self.meeting.interviewee
    end

    def not_applicant?
      self.user != self.meeting.interviewee
    end

end
