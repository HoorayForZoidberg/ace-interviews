class Review < ApplicationRecord
  belongs_to :meeting
  belongs_to :user
  validates :rating, inclusion: { in: 1..5 }
  validates :user, presence: true
end
