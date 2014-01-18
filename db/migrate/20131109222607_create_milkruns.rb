class CreateMilkruns < ActiveRecord::Migration
  def change
    create_table :milkruns do |t|
      t.date    :date
      t.integer :cycle_id
      
      # PRICES
      t.decimal :mprice
      t.decimal :bprice
      t.decimal :cprice
      
      # GAS
      t.decimal :gasprice
      t.integer :distance
      t.integer :mpg
      
      # ICE
      t.decimal :iceprice

      # COOLERS
      t.integer :cool1
      t.integer :cool1_ice

      t.integer :cool2
      t.integer :cool2_ice

      t.integer :cool3
      t.integer :cool3_ice

      t.integer :bag
      t.decimal :bag_ice

      t.boolean :active, default: false

      t.timestamps
    end
  end
end
