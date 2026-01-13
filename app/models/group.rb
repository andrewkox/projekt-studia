class Group < ApplicationRecord
  belongs_to :studio
  has_many :students

  has_many :group_courses, dependent: :destroy
  has_many :courses, through: :group_courses
end
