class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.integer :account_id
      t.decimal :amount

      t.timestamps
    end
  end
end
