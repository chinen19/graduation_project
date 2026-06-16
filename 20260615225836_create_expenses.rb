class CreateExpenses < ActiveRecord::Migration[7.0]
  def change
    create_table :expenses do |t|
      t.references :user, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true
      t.date :date, null: false
      t.integer :amount, null: false
      t.string :description
      t.integer :inout_type, null: false

      t.timestamps
    end
  end
end