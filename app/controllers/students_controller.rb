class StudentsController < ApplicationController
  before_action :set_student, only: %i[ show edit update destroy ]

  def index
    @students = Student.all
  end

  def show
    @student = Student.find(params[:id])
    @semesters = Semester.order(start_date: :desc)

    @semester = nil
    @grades = []
  end


  # turbo frame: kliknięcie semestru
  def semester
    @student  = Student.find(params[:id])
    @semester = Semester.find(params[:semester_id])
    @grades   = @student.grades.where(semester: @semester).includes(:course)

    render layout: false
  end






  def ranking
    @semester = Semester.find(params[:semester_id])
    @students = Student
                  .joins(:grades)
                  .where(grades: { semester: @semester })
                  .group("students.id")
                  .sort_by { |s| -s.average_for_semester(@semester).to_f }
  end

  def pdf
    @student = Student.find(params[:id])
    @grades  = @student.grades.includes(:course, :semester)

    render pdf: "indeks_#{@student.last_name}",
           template: "students/pdf",
           formats: [:html],
           disposition: "inline"
  end

  def new
    @student = Student.new
  end

  def edit
  end

  def create
    @student = Student.new(student_params)

    if @student.save
      redirect_to @student, notice: "Student was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @student.update(student_params)
      redirect_to @student, notice: "Student was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @student.destroy
    redirect_to students_path, notice: "Student was successfully destroyed."
  end

  private

  def set_student
    @student = Student.find(params[:id])
  end

  def student_params
    params.require(:student).permit(:first_name, :last_name, :album, :group_id)
  end
end
