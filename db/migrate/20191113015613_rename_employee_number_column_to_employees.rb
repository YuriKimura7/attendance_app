class RenameEmployeeNumberColumnToEmployees < ActiveRecord::Migration[6.0]
  def change
    rename_column :employees, :employee_number, :number
  end
end
