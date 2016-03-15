class AddAdminToPeople < ActiveRecord::Migration
  def change
    add_column :people, :admin, :boolean, default: false
    # Column values default to nil, but we're just being explicit here so 
    # that it's easier to toggle in the future.
    # Also note that adding boolean columns automatically adds the a boolean
    # method to the model. In this case, Person.boolean?.
  end
end
