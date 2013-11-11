class CreateMilkruns < ActiveRecord::Migration
  def change
    create_table :milkruns do |t|
      t.date :date
      t.decimal :gasprice
      t.integer :distance
      t.integer :mpg
      t.decimal :iceprice

      t.timestamps
    end
  end
end
