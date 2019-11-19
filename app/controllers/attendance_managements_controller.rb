class AttendanceManagementsController < ApplicationController
  def new
    @attendance_management = AttendanceManagement.new
  end

  def create
    @attendance_management = AttendanceManagement.new(attendance_params)
  end

  private
  def attendance_params
    params.require(:attendance_management).permit(:attendance, :time, :employee_id)
  end
end
