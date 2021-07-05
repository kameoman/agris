class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name
      t.datetime :date
      t.integer :send
      t.text :comment
      t.integer :count
      t.string :standard
      t.string :image_id

      t.timestamps
    end
  end
end
