class GradesController < ApplicationController
  def create
    @grade = Grade.new(grade_params)

    if @grade.save
      @student  = @grade.student
      @semester = @grade.semester
      @grades   = @student.grades.where(semester: @semester).includes(:course)

      render partial: "students/semester_grades",
             locals: { student: @student, semester: @semester, grades: @grades }
    else
      head :unprocessable_entity
    end
  end

  def destroy
    @grade = Grade.find(params[:id])
    @student  = @grade.student
    @semester = @grade.semester

    @grade.destroy

    @grades = @student.grades.where(semester: @semester).includes(:course)

    render partial: "students/semester_grades",
           locals: { student: @student, semester: @semester, grades: @grades }
  end

  private

  def grade_params
    params.require(:grade).permit(:student_id, :course_id, :semester_id, :grade)
  end
end
