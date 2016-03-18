class AddResetToPeople < ActiveRecord::Migration
  def change
    add_column :people, :reset_digest, :string
    add_column :people, :reset_sent_at, :datetime
  end
end
