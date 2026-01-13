# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2026_01_13_174234) do
  create_table "admins", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email"
    t.string "password_digest"
    t.datetime "updated_at", null: false
  end

  create_table "courses", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "ects"
    t.string "name"
    t.datetime "updated_at", null: false
  end

  create_table "courses_groups", id: false, force: :cascade do |t|
    t.integer "course_id", null: false
    t.integer "group_id", null: false
  end

  create_table "grades", force: :cascade do |t|
    t.integer "course_id", null: false
    t.integer "grade"
    t.integer "semester_id", null: false
    t.integer "student_id", null: false
    t.index ["semester_id"], name: "index_grades_on_semester_id"
  end

  create_table "group_courses", force: :cascade do |t|
    t.integer "course_id", null: false
    t.datetime "created_at", null: false
    t.integer "group_id", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_group_courses_on_course_id"
    t.index ["group_id"], name: "index_group_courses_on_group_id"
  end

  create_table "groups", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.integer "studio_id", null: false
    t.datetime "updated_at", null: false
    t.index ["studio_id"], name: "index_groups_on_studio_id"
  end

  create_table "semesters", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.date "end_date"
    t.string "name"
    t.date "start_date"
    t.datetime "updated_at", null: false
  end

  create_table "students", force: :cascade do |t|
    t.string "album"
    t.datetime "created_at", null: false
    t.string "first_name"
    t.integer "group_id", null: false
    t.string "last_name"
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_students_on_group_id"
  end

  create_table "studios", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.datetime "updated_at", null: false
  end

  create_table "teachers", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email"
    t.string "first_name"
    t.string "last_name"
    t.integer "studio_id", null: false
    t.datetime "updated_at", null: false
    t.index ["studio_id"], name: "index_teachers_on_studio_id"
  end

  add_foreign_key "grades", "semesters"
  add_foreign_key "group_courses", "courses"
  add_foreign_key "group_courses", "groups"
  add_foreign_key "groups", "studios"
  add_foreign_key "students", "groups"
  add_foreign_key "teachers", "studios"
end
