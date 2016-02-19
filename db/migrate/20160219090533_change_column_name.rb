class ChangeColumnName < ActiveRecord::Migration
  def change
    rename_column :people, :salt, :password_salt
  end
end
