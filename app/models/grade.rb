class Grade < ApplicationRecord
  belongs_to :student
  belongs_to :course
  belongs_to :semester
end
