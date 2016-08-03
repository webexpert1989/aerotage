class AddFirstActivatedAtToListings < ActiveRecord::Migration
  def change
    add_column :listings, :first_activated_at, :datetime, default: nil
  end
end
