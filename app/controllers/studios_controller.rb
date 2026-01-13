class StudiosController < ApplicationController
  before_action :set_studio, only: %i[ show edit update destroy ]

  # ========================
  # DASHBOARD (panel dziekana)
  # ========================
  def dashboard
    @students = Student.includes(:grades, :group)
    @groups   = Group.all

    all_grades = Grade.pluck(:grade)
    @school_avg = all_grades.any? ? (all_grades.sum.to_f / all_grades.size).round(2) : 0

    @best_student = @students.max_by { |s| s.average_grade.to_f }
  end

  # ========================
  # CRUD STUDIOS
  # ========================

  # GET /studios
  def index
    @studios = Studio.all
  end

  # GET /studios/1
  def show
  end

  # GET /studios/new
  def new
    @studio = Studio.new
  end

  # GET /studios/1/edit
  def edit
  end

  # POST /studios
  def create
    @studio = Studio.new(studio_params)

    if @studio.save
      redirect_to @studio, notice: "Studio zostało utworzone."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /studios/1
  def update
    if @studio.update(studio_params)
      redirect_to @studio, notice: "Studio zostało zaktualizowane."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /studios/1
  def destroy
    @studio.destroy
    redirect_to studios_path, notice: "Studio zostało usunięte."
  end

  private

  # ========================
  # CALLBACKS
  # ========================
  def set_studio
    @studio = Studio.find(params[:id])
  end

  # ========================
  # STRONG PARAMS
  # ========================
  def studio_params
    params.require(:studio).permit(:name)
  end

  def semester
    @semester = Semester.find(params[:id])
    @ranking = @semester.ranking

    render partial: "studios/ranking", locals: { semester: @semester, ranking: @ranking }
  end

end
