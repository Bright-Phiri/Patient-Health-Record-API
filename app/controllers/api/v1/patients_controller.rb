module Api
    module V1
      class PatientsController < ApplicationController
         before_action :set_patient, only: [:show, :update, :destroy]
 
         def index
           patients = Patient.all
           render json: { status: 'success', message: 'Loaded patients',data: patients}, status: :ok
         end

         def statistics
             render json: { status: 'success',patients: Patient.count, users: User.count, vital_signs:VitalSign.count}, status: :ok
         end
 
         def show 
            render json: { status: 'success', message: 'Loaded patient',data: @patient}, status: :ok
         end
 
         def create 
             patient = Patient.new(patient_params)
             if patient.save
                 render json: { status: 'success', message: 'Patient successfully created',data: patient}, status: :created
             else
                 render json: { status: 'error', message: 'Failed to create patient', data: patient.errors.full_messages}
             end
         end 
 
         def update
             if @patient.update(patient_params)
                 render json: { status: 'success', message: 'Patient successfully updated',data: @patient}, status: :ok
             else
                 render json: { status: 'error', message: 'Failed to update patient',data: @patient.errors.full_messages}
             end
         end
 
         def destroy
             if @patient.destroy
                 render json: { status: 'success', message: 'Patient successfully deleted',data: @patient}, status: :ok
             else 
                 render json: { status: 'error', message: 'Failed to delete patient'}
             end
         end
         
         private
 
         def patient_params
             params.permit(:first_name, :last_name, :gender, :dob, :district, :village, :occupation)
         end
 
         def set_patient
             @patient = Patient.find(params[:id])
         end
         
      end
    end
 end