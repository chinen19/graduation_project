class ChangeCommentNullInProducts < ActiveRecord::Migration[7.0]
  def change
    change_column_null :products, :comment, true
  end
end

