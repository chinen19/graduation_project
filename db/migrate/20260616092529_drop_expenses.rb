class DropExpenses < ActiveRecord::Migration[7.0]
  def change
    drop_table :expenses, if_exists: true
  end
end
