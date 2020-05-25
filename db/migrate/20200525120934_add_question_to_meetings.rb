class AddQuestionToMeetings < ActiveRecord::Migration[6.0]
  def change
    add_reference :meetings, :question, null: false, foreign_key: true
  end
end