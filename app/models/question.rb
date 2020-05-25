class Question < ApplicationRecord
  has_many :meetings

  validates :industry, presence: true
  validates :type, presence: true
end
