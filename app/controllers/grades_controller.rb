class GradesController < ApplicationController
  def create
    @grade    = Grade.new(grade_params)
    @student  = @grade.student
    @semester = @grade.semester
    @grade.save

    @grades = @student.grades.where(semester: @semester).includes(:course)

    render "students/semester", layout: false
  end

  def destroy
    @grade    = Grade.find(params[:id])
    @student  = @grade.student
    @semester = @grade.semester
    @grade.destroy

    @grades = @student.grades.where(semester: @semester).includes(:course)

    render "students/semester", layout: false
  end


  private

  def grade_params
    params.require(:grade).permit(:student_id, :course_id, :semester_id, :grade)
  end
end
