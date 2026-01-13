class CoursesController < ApplicationController
  before_action :set_course, only: %i[
    show edit update destroy
    grades grades_edit grades_save
  ]

  # GET /courses
  def index
    @courses = Course.all
  end

  # GET /courses/1
  def show
  end

  # GET /courses/new
  def new
    @course = Course.new
  end

  # GET /courses/1/edit
  def edit
  end

  # POST /courses
  def create
    @course = Course.new(course_params)

    if @course.save
      redirect_to @course, notice: "Course was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /courses/1
  def update
    if @course.update(course_params)
      redirect_to @course, notice: "Course was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /courses/1
  def destroy
    @course.destroy
    redirect_to courses_path, notice: "Course was successfully destroyed."
  end

  # ============================
  # ========= GRADES ===========
  # ============================

  # GET /courses/:id/grades?group_id=1
  def grades
    @group = Group.find(params[:group_id])
    @students = @group.students
  end

  # GET /courses/:id/grades_edit?group_id=1
  def grades_edit
    @group = Group.find(params[:group_id])
    @students = @group.students
  end

  # POST /courses/:id/grades_save?group_id=1
  def grades_save
    @group = Group.find(params[:group_id])

    params[:grades].each do |student_id, grade|
      record = Grade.find_or_initialize_by(
        student_id: student_id,
        course_id: @course.id
      )
      record.grade = grade
      record.save
    end

    redirect_to grades_course_path(@course, group_id: @group.id)
  end

  private

  def set_course
    @course = Course.find(params[:id])
  end

  def course_params
    params.require(:course).permit(:name, :ects)
  end
end
