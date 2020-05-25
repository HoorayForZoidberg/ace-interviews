class CreateMeetings < ActiveRecord::Migration[6.0]
  def change
    create_table :meetings do |t|
      t.date :date
      t.integer :interviewee_id, null: false, foreign_key: true
      t.integer :interviewer_id, null: false, foreign_key: true
      t.boolean :finished, default: false

      t.timestamps
    end
    add_index :meetings, :interviewer_id
    add_index :meetings, :interviewee_id
  end
end
