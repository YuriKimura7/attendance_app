class AttendanceManagementsController < ApplicationController
  def new
    @attendance_management = AttendanceManagement.new
  end

  def create
    @attendance_management = AttendanceManagement.new(attendance_params)
    if @attendance_management.save
      if @attendance_management.attendance == 'going'
        redirect_to new_attendance_management_path,
        notice: "#{ @attendance_management.employee.name }さん、おはようございます。"
      else
        redirect_to new_attendance_management_path,
        notice: "#{ @attendance_management.employee.name }さん、お疲れ様です。"
      end
    end
  end

  private
  def attendance_params
    params.require(:attendance_management).permit(:attendance, :time, :employee_id)
  end
end
