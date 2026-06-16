class CreateExpenses < ActiveRecord::Migration[7.0]
  def change
    create_table :expenses do |t|
      t.references :user, null: false, foreign_key: true
      t.date :date, null: false
      t.integer :amount, null: false
      t.references :category, null: false, foreign_key: true
      t.text :note

      t.timestamps
    end
  end
end
