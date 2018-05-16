class AddConstraintNullToRent < ActiveRecord::Migration[5.1]
  def change
    change_column_null :rents, :user_id, false
    change_column_null :rents, :book_id, false
    change_column_null :rents, :from, false
    change_column_null :rents, :to, false
  end
end
