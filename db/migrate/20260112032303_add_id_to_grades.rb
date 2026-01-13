class AddIdToGrades < ActiveRecord::Migration[7.1]
  def change
    add_column :grades, :id, :primary_key
  end
end
