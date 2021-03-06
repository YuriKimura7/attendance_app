class AttendanceManagement < ApplicationRecord
  belongs_to :employee
  enum attendance: { going: 0, leaving: 1 }

  validates :employee_id, presence: true
end
