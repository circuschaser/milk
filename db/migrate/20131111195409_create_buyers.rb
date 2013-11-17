class CreateBuyers < ActiveRecord::Migration
  def change
    create_table :buyers do |t|
      t.string :firstname
      t.string :lastname
      t.string :phone
      t.string :altphone
      t.string :email

      t.integer :deposit
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
