class Student < ApplicationRecord
  belongs_to :group
  has_many :grades, dependent: :destroy
  has_many :courses, through: :grades

  def average_grade
    return nil if grades.empty?
    grades.average(:grade).to_f.round(2)
  end

  def passed?
    average_grade && average_grade >= 3.0
  end
  def average_for_semester(semester)
    grades
      .where(semester: semester)
      .average(:grade)
      &.round(2)
  end

  def ects_for_semester(semester)
    grades
      .joins(:course)
      .where(semester: semester)
      .sum("courses.ects")
  end

  def passed_semester?(semester)
    avg = average_for_semester(semester)
    ects = ects_for_semester(semester)

    avg && avg >= 3.0 && ects >= 30
  end

end
