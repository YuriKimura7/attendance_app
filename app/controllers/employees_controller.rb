class EmployeesController < ApplicationController
  def index
    @employees = Employee.all
  end

  def new
    @employee = Employee.new
  end

  def create
    @employee = Employee.new(employee_params)
    if @employee.save
      redirect_to employees_path, notice: "登録しました"
    else
      render 'new'
    end
  end

  def edit
    @employee = Employee.find_by(params[:id])
  end

  def update
    @employee = Employee.find_by(params[:id])
    if @employee.update(employee_params)
      redirect_to employees_path, notice: "編集しました"
    else
      render 'edit'
    end
  end

  private

  def employee_params
    params.require(:employee).permit(:name, :number)
  end
end
