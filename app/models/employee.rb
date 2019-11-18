class Employee < ApplicationRecord
  has_many :attendance_managements

  validates :name, presence: true
  validates :number, presence: true
  validates :number, uniqueness: true
end
