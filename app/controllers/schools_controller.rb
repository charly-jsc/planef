# SchoolsController
class SchoolsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_school, only: [:show, :edit, :update, :destroy]

  # GET /schools
  # GET /schools.json
  def index
    @schools = School.all
  end

  # GET /schools/1
  # GET /schools/1.json
  def show
    authorize! :read, School
  end

  # GET /schools/new
  def new
    authorize! :create, School
    @school = School.new
  end

  # GET /schools/1/edit
  def edit
    authorize! :update, @school
  end

  # POST /schools
  # POST /schools.json
  def create
    authorize! :create, School
    @user = current_user
    @school = @user.schools.build(school_params)
    @user.schools << @school
    respond_to do |format|
      if @school.save
        format.html do
          redirect_to @user, notice: 'Colegio creado con éxito.'
        end
        format.json { render :show, status: :created, location: @school }
      else
        format.html { render :new }
        format.json do
          render json: @school.errors, status: :unprocessable_entity
        end
      end
    end
  end

  # PATCH/PUT /schools/1
  # PATCH/PUT /schools/1.json
  def update
    authorize! :update, @school
    respond_to do |format|
      if @school.update(school_params)
        format.html do
          redirect_to @school, notice: 'Colegio editado con éxito'
        end
        format.json { render :show, status: :ok, location: @school }
      else
        format.html { render :edit }
        format.json do
          render json: @school.errors, status: :unprocessable_entity
        end
      end
    end
  end

  # DELETE /schools/1
  # DELETE /schools/1.json
  def destroy
    authorize! :destroy, @school
    @school.destroy
    respond_to do |format|
      format.html do
        redirect_to schools_url, notice: 'School was successfully destroyed.'
      end
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_school
    @school = School.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list
  # through.
  def school_params
    params.require(:school).permit(:name, :RBD, :address, :phone, :code)
  end
end
