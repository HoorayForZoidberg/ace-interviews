class AddUniversityReferenceToUsers < ActiveRecord::Migration[6.0]
  def change
    add_reference :users, :university, foreign_key: true, null: false
  end
end
