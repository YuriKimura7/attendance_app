class Employee < ApplicationRecord
  validates :name, presence: true
  validates :number, presence: true
  validates :number, uniqueness: true
end
