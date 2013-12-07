class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :buyer_id
      t.integer :milkrun_id
      t.date    :date

      t.integer :milk
      t.integer :buttermilk
      t.integer :cream
      
      t.boolean :driver

      t.timestamps
    end
  end
end
