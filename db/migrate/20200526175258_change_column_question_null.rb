class ChangeColumnQuestionNull < ActiveRecord::Migration[6.0]
  def change
    change_column_null :meetings, :question_id, true
  end
end
