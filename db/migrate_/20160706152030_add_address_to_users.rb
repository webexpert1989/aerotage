class AddAddressToUsers < ActiveRecord::Migration
  def change
    add_column :users, :password_digest, :string
    add_column :users, :remember_digest, :string
    add_column :users, :send_mailings, :boolean
    add_column :users, :location_id, :integer
    add_column :users, :address, :string
  end
end