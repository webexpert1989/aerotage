class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.belongs_to :user, index: true
      t.string :description
      t.integer :transaction_type
      t.integer :amount
      t.integer :balance

      t.timestamps
    end
  end
end
