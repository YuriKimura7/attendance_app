class AttendanceManagement < ApplicationRecord
  belongs_to :employee
  enum attendance: { going: 0, leaving: 1 }

  validate :attendance_check

  def attendance_check
    during_work = AttendanceManagement.find_by(employee_id: employee, time: Date.today.all_day)
    left_the_office = AttendanceManagement.find_by(attendance: :leaving, employee_id: employee, time: Date.today.all_day)
    if attendance == "going" && during_work
      errors.add(:base, "#{ employee.name }さんはすでに出社しています。")
    elsif !during_work && attendance == "leaving"
      errors.add(:base, "#{ employee.name }さんの出社データがありません。")
    elsif left_the_office && attendance == "leaving"
      errors.add(:base, "#{ employee.name }さんはすでに退社してます。")
    end
  end
end