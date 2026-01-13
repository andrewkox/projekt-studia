class CreateGroupCourses < ActiveRecord::Migration[8.1]
  def change
    create_table :group_courses do |t|
      t.references :group, null: false, foreign_key: true
      t.references :course, null: false, foreign_key: true

      t.timestamps
    end
  end
end
