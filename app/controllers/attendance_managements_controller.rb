class AttendanceManagementsController < ApplicationController
  def index
    @days = Date.today
    if params["year_and_month(1i)"].present? && params["year_and_month(2i)"].present?
      @days = Date.new(params["year_and_month(1i)"].to_i,params["year_and_month(2i)"].to_i,params["year_and_month(3i)"].to_i)
    end
    @attendance_managements = AttendanceManagement.where(employee_id: params[:employee]).where(time: @days.all_month) if params[:employee].present?
    @employee = Employee.find(params[:employee]) if params[:employee].present?
  end

  def new
    @attendance_management = AttendanceManagement.new
  end

  def create
    @attendance_management = AttendanceManagement.new(attendance_params)
    @attendance_going = AttendanceManagement.find_by(employee_id: attendance_params[:employee_id], time: Date.new(attendance_params["time(1i)"].to_i, attendance_params["time(2i)"].to_i, attendance_params["time(3i)"].to_i).all_day)
    @attendance_leaving = AttendanceManagement.find_by(attendance: 1, employee_id: attendance_params[:employee_id], time: Date.new(attendance_params["time(1i)"].to_i, attendance_params["time(2i)"].to_i, attendance_params["time(3i)"].to_i).all_day)
    if (@attendance_management.going? && !@attendance_going) || (@attendance_going && !@attendance_leaving && @attendance_management.leaving?)
      if @attendance_management.save
        redirect_to new_attendance_management_path, notice: message
      else
        render 'new'
      end
    else
      redirect_to new_attendance_management_path, notice: error_message
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

  def wday_class(wday)
      wday == 6 ? 'blue' : wday == 1 ? 'red' : ''
  end
  helper_method :wday_class

  def error_message
    if @attendance_management.going? && @attendance_going
      @attendance_management.errors.add(:attendance, "#{ @attendance_management.employee.name }さんは既に出社してます。")
    elsif !@attendance_going && @attendance_management.leaving?
      @attendance_management.errors.add(:attendance, "#{ @attendance_management.employee.name }さんの出社データがありません")
    elsif @attendance_leaving && @attendance_management.leaving?
      @attendance_management.errors.add(:attendance, "#{ @attendance_management.employee.name }さんは既に退社してます。")
    end
  end
end
