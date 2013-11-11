class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.integer :buyer_id
      t.decimal :balance

      t.timestamps
    end
  end
end
