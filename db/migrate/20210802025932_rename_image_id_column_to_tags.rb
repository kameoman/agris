class RenameImageIdColumnToTags < ActiveRecord::Migration[5.2]
  def change
    rename_column :tags, :image_id, :item_id
  end
end
