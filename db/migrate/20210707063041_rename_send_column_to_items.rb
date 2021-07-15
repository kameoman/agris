class RenameSendColumnToItems < ActiveRecord::Migration[5.2]
  def change
    rename_column :items, :send, :send_method
  end
end
