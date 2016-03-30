class AddColumnsToPeople < ActiveRecord::Migration
  def change
  	add_column :people, :gender, :binary
  	add_column :people, :company, :text
  	add_column :people, :address, :text
  	add_column :people, :bio, :text
  end
end
