class ChangeColumnToNull < ActiveRecord::Migration[5.2]
  def change
    change_column_null :items, :send, default: "", null: false

  end
end
