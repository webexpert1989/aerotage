class CreateFlags < ActiveRecord::Migration
  def change
    create_table :flags do |t|
      t.integer :flag_type
      t.text :comment
      t.belongs_to :listing, index: true
      t.belongs_to :user, index: true

      t.timestamps
    end
  end
end
