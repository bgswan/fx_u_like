class CreateRates < ActiveRecord::Migration
  def change
    create_table :rates do |t|
      t.date :rate_at
      t.string :currency
      t.float :rate

      t.timestamps null: false
    end

    add_index :rates, [:rate_at, :currency], unique: true
  end
end
