class StudentsController < ApplicationController
  before_action :set_student, only: %i[ show edit update destroy ]

  # GET /students
  def index
    @students = Student.all
  end

  # GET /students/1
  def show
    @student = Student.find(params[:id])

    @grades = @student.grades
                      .where.not(id: nil)
                      .includes(:course, :semester)

    @new_grade = Grade.new(student: @student)

    @semesters = Semester.order(start_date: :desc)
  end

  def semester
    @student = Student.find(params[:id])
    @semester = Semester.find(params[:semester_id])
    @grades = @student.grades.where(semester: @semester).includes(:course)

    render partial: "students/grades", locals: { student: @student, grades: @grades }
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



  # GET /students/new
  def new
    @student = Student.new
  end

  # GET /students/1/edit
  def edit
  end

  # POST /students
  def create
    @student = Student.new(student_params)

    respond_to do |format|
      if @student.save
        format.html { redirect_to @student, notice: "Student was successfully created." }
        format.json { render :show, status: :created, location: @student }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /students/1
  def update
    respond_to do |format|
      if @student.update(student_params)
        format.html { redirect_to @student, notice: "Student was successfully updated." }
        format.json { render :show, status: :ok, location: @student }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /students/1
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
