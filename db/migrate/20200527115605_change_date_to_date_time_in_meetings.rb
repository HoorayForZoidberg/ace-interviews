class ChangeDateToDateTimeInMeetings < ActiveRecord::Migration[6.0]
  def change
    change_column :meetings, :date, :datetime
  end
end
