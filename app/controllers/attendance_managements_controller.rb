class AttendanceManagementsController < ApplicationController
  def index
    @attendance_managements = AttendanceManagement.all
    @attendance_managements = @attendance_managements.where(time: params[:year_and_month]) if params[:year_and_month].present?
  end

  def new
    @attendance_management = AttendanceManagement.new
  end

  def create
    @attendance_management = AttendanceManagement.new(attendance_params)
    if @attendance_management.save
      redirect_to new_attendance_management_path, notice: message
    else
      render 'new'
    end
  end

  private
  def attendance_params
    params.require(:attendance_management).permit(:attendance, :time, :employee_id)
  end

  def message
    if @attendance_management.going?
      "#{ @attendance_management.employee.name }さん、おはようございます。"
    else
      "#{ @attendance_management.employee.name }さん、お疲れ様です。"
    end
  end
end
