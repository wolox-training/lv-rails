class AddNullConstraintToBook < ActiveRecord::Migration[5.1]
  def change
    change_table(:books) do
      %i[genre author image title publisher year].each do |attr|
        change_column_null :books, attr, false
      end
    end
  end
end
