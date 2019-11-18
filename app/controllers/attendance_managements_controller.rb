class AttendanceManagementsController < ApplicationController
  def new
    @attendance_management = AttendanceManagement.new
  end

  def create
  end
end
