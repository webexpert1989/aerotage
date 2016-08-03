class CreateSearches < ActiveRecord::Migration
  def change
    create_table :searches do |t|
      t.string :title
      t.integer :frequency, default: 0
      t.date :last_sent
      t.boolean :active, default: false
      t.integer :user_id
      t.text :conditions
      t.string :target_class

      t.timestamps
    end
  end
end
