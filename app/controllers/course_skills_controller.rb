class CourseSkillsController < ApplicationController
  include PrerequisitesHelper
  before_action :set_course_skill, only: [:show, :edit, :update, :destroy]

  # GET /course_skills
  # GET /course_skills.json
  def index
    @course_skills = CourseSkill.all
  end

  # GET /course_skills/1
  # GET /course_skills/1.json
  def show
  end

  # GET /course_skills/new
  def new
    @course_skill = CourseSkill.new
    @courses = getCourses().to_json
    skills = Skill.all
    @skills = { results: [] }
    skills.each do |skill|
      @skills[:results].push({id: skill.id, text: skill.name})
    end
    @skills = @skills.to_json
  end

  # GET /course_skills/1/edit
  def edit
  end

  # POST /course_skills
  # POST /course_skills.json
  def create
    params[:course_skill][:skill_ids].each do |skill|
      @course_skill = CourseSkill.new(course_id: params[:course_skill][:course_id], skill_id: skill)
      @course_skill.save
    end
    redirect_to '/course_skills'
    #@course_skill = CourseSkill.new(course_skill_params)
    return
    respond_to do |format|
      if @course_skill.save
        format.html { redirect_to @course_skill, notice: 'Course skill was successfully created.' }
        format.json { render :show, status: :created, location: @course_skill }
      else
        format.html { render :new }
        format.json { render json: @course_skill.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /course_skills/1
  # PATCH/PUT /course_skills/1.json
  def update
    respond_to do |format|
      if @course_skill.update(course_skill_params)
        format.html { redirect_to @course_skill, notice: 'Course skill was successfully updated.' }
        format.json { render :show, status: :ok, location: @course_skill }
      else
        format.html { render :edit }
        format.json { render json: @course_skill.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /course_skills/1
  # DELETE /course_skills/1.json
  def destroy
    @course_skill.destroy
    respond_to do |format|
      format.html { redirect_to course_skills_url, notice: 'Course skill was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course_skill
      @course_skill = CourseSkill.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_skill_params
      params.require(:course_skill).permit(:course_id, :skill_id)
    end
end
