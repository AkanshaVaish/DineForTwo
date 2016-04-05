class AddColumnToPeople < ActiveRecord::Migration
  def change
    add_column :people, :location_id, :integer
  end
end
