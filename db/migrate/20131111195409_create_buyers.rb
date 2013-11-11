class CreateBuyers < ActiveRecord::Migration
  def change
    create_table :buyers do |t|
      t.string :name
      t.string :phone
      t.string :altphone
      t.string :email
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
