class University < ApplicationRecord
  has_many :users
  include PgSearch::Model
  pg_search_scope :search,
                  against: [ :name ],
                  using: {
                    tsearch: { prefix: true }
                  }
end
