class AddFiledsToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :firstname, :string
    add_column :users, :lastname, :string
    add_column :users, :phone_no, :string
    add_column :users, :address, :text
  end
end
