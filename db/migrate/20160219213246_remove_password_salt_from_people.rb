class RemovePasswordSaltFromPeople < ActiveRecord::Migration
  def change
    remove_column :people, :password_salt
  end
end
