class Course < ApplicationRecord
  has_many :group_courses, dependent: :destroy
  has_many :groups, through: :group_courses
end
