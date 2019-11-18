class CreateAttendanceManagements < ActiveRecord::Migration[6.0]
  def change
    create_table :attendance_managements do |t|
      t.integer :attendance
      t.datetime :time
      t.integer :employee_id

      t.timestamps
    end
  end
end
