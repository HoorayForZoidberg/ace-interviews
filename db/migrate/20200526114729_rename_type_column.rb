class RenameTypeColumn < ActiveRecord::Migration[6.0]
  def change
    rename_column :questions, :type, :discipline
  end
end
