class AddLongitudeToCustomers < ActiveRecord::Migration[5.2]
  def change
    add_column :customers, :longitude, :float
  end
end
