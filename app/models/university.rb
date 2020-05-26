class University < ApplicationRecord
  has_many :users
  # all_u = []
  # University.each do |university|
  #   all_u << university.name
  # end

end
