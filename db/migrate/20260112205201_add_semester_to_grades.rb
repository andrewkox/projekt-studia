class AddSemesterToGrades < ActiveRecord::Migration[7.1]
  def change
    add_reference :grades, :semester, foreign_key: true, null: true
  end
end
