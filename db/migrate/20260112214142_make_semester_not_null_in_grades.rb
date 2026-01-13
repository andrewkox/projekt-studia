class MakeSemesterNotNullInGrades < ActiveRecord::Migration[7.1]
  def change
    change_column_null :grades, :semester_id, false
  end
end
