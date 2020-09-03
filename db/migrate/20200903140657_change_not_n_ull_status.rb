class ChangeNotNUllStatus < ActiveRecord::Migration[5.2]
  def change
    change_column_null :tasks, :status, false, "未着手"
  end
end
