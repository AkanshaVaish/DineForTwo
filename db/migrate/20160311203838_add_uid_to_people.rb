class AddUidToPeople < ActiveRecord::Migration
  def change
    add_column :people, :uid, :string
    add_column :people, :image_url, :string
    add_column :people, :url, :string
    add_index :people, :uid, unique: true
  end
end
