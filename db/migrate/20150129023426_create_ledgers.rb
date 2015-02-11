class CreateLedgers < ActiveRecord::Migration
  def change
    create_table :ledgers do |t|
      t.integer :user_id
      t.string :description
      t.decimal :amount

      t.boolean :cleared

      t.timestamps :date
    end
  end
end
