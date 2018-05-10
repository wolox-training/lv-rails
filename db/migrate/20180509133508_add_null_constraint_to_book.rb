class AddNullConstraintToBook < ActiveRecord::Migration[5.1]
  def change
    change_table(:books) do
      change_column_null :books, :genre, false
      change_column_null :books, :author, false
      change_column_null :books, :image, false
      change_column_null :books, :title, false
      change_column_null :books, :publisher, false
      change_column_null :books, :year, false
    end
  end
end
