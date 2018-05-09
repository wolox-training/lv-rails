class AddNullConstraintToBook < ActiveRecord::Migration[5.1]
  def change
    change_table(:users) do |t|
      change_column_null :genre, :author, :image, :title, :publisher, :year, false
    end
  end
end
