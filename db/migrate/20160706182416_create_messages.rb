class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.belongs_to :application, index: true
      t.string :sender, limit: 20
      t.boolean :is_read, default: false
      t.text :content

      t.timestamps
    end
  end
end
