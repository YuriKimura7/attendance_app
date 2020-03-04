require 'rails_helper'

RSpec.describe 'attendance_management_new', type: :system do
  it '出社打刻ができること' do
    Employee.create(name: 'おもす', number: 1)
    Employee.create(name: '木村', number: 2)

    expected_value = {
      id: 1,
      attendance: "going",
      time: DateTime.new(2020,3,4,10,00),
      employee_id: 2,
      created_at: Time.now,
      updated_at: Time.now
    }

    visit '/attendance_managements/new'
    select('木村', from: 'attendance_management_employee_id')
    select('2020', from: 'attendance_management[time(1i)]')
    select('3', from: 'attendance_management[time(2i)]')
    select('4', from: 'attendance_management[time(3i)]')
    select('10', from: 'attendance_management[time(4i)]')
    select('00', from: 'attendance_management[time(5i)]')
    select('出社', from: 'attendance_management_attendance')
    click_button('登録')
    kimura = {
      id: AttendanceManagement.last.id,
      attendance: AttendanceManagement.last.attendance,
      time: AttendanceManagement.last.time,
      employee_id: AttendanceManagement.last.employee_id,
      created_at: AttendanceManagement.last.created_at,
      updated_at: AttendanceManagement.last.updated_at
    }
    binding.pry
    expect(kimura).to eq(expected_value)
    # expect(page).to have_content '木村さん、おはようございます。'
  end
end
