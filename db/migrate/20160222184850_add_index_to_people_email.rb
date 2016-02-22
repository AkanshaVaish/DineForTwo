class AddIndexToPeopleEmail < ActiveRecord::Migration
  def change
    add_index :people, :email, unique: true
    # This guarantees uniqueness on the database level
    # Also helps speed up look ups when people rows increase
  end
end
