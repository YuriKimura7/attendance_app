require 'rails_helper'

RSpec.describe 'attendance_management_new', type: :system do
  it '出社打刻ができること' do
    Employee.create(name: 'おもす', number: 1)
    Employee.create(name: '木村', number: 2)

    visit '/attendance_managements/new'
    select('木村', from: 'attendance_management_employee_id')
    select('2020', from: 'attendance_management[time(1i)]')
    select('3', from: 'attendance_management[time(2i)]')
    select('4', from: 'attendance_management[time(3i)]')
    select('10', from: 'attendance_management[time(4i)]')
    select('00', from: 'attendance_management[time(5i)]')
    select('出社', from: 'attendance_management_attendance')
    click_button('登録')

    kimura = AttendanceManagement.last

    expect(kimura).to have_attributes(attendance: 'going', time: DateTime.new(2020,3,4,10,00))
    expect(page).to have_content '木村さん、おはようございます。'
  end
end
