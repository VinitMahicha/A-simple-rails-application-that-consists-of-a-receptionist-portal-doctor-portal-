class PatientsController < ApplicationController
  before_action :set_patient, only: %i[ show edit update destroy ]

  # GET /patients or /patients.json
  def index
    # Print out the value of the instance variable @patients, loop throught each of them
    # and print out the value of each patient's name attribute.
    # allow only authenticated users to view the list of patients
    if user_signed_in?
      @patients = Patient.all
    else
      redirect_to new_user_session_path
    end
  end

  # GET /patients/1 or /patients/1.json
  def show
  end

  # GET /patients/new
  def new
    if user_signed_in?
      @patient = Patient.new
    else
      redirect_to new_user_session_path
    end
  end

  # GET /patients/1/edit
  def edit
    if user_signed_in?
      @patient = Patient.find(params[:id])
    else
      redirect_to new_user_session_path
    end
  end

  # POST /patients or /patients.json
  def create
    if user_signed_in?
      @patient = Patient.new(patient_params)

      respond_to do |format|
        if @patient.save
          format.html { redirect_to patient_url(@patient), notice: "Patient was successfully created." }
          format.json { render :show, status: :created, location: @patient }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @patient.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to new_user_session_path
    end
  end

  # PATCH/PUT /patients/1 or /patients/1.json
  def update
    if user_signed_in?
      respond_to do |format|
        if @patient.update(patient_params)
          format.html { redirect_to patient_url(@patient), notice: "Patient was successfully updated." }
          format.json { render :show, status: :ok, location: @patient }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @patient.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to new_user_session_path
    end
  end

  # DELETE /patients/1 or /patients/1.json
  def destroy
    if user_signed_in?
      @patient.destroy

      respond_to do |format|
        format.html { redirect_to patients_url, notice: "Patient was successfully destroyed." }
        format.json { head :no_content }
      end
    else
      redirect_to new_user_session_path
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_patient
      @patient = Patient.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def patient_params
      params.require(:patient).permit(:name, :email, :problem)
    end
end
