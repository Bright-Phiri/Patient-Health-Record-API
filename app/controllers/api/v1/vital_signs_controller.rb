module Api
    module V1
        class VitalSignsController  < ApplicationController

            def create
                if Patient.where(id: params[:patient_id]).exists?
                    patient = Patient.find(params[:patient_id])
                    vital_signs = patient.vital_signs.create(weight: params[:weight],height: params[:height],temp_reading: params[:temp_reading],diagnosis: params[:diagnosis])
                    if vital_signs.persisted?
                      render json: { status: 'success', message: 'Vital signs successfully added to the patient',data: vital_signs}, status: :created
                    else
                      render json: { status: 'error', message: 'Failed to add vital signs to patient', data: vital_signs.errors.full_messages}
                    end
                else
                    render json: { status: 'error', message: 'Patient record not found'} 
                end
            end

            def show
                vital_signs = VitalSign.where(patient_id: params[:id])
                if vital_signs.blank?
                    render json: { status: 'error', message: 'Virtal signs not recorded for this patient'}
                else
                    render json: { status: 'success', message: 'Vital signs loaded',data: vital_signs}, status: :ok
                end
            end

            private

            def vital_signs_params
                params.permit(:id, :weight, :height, :temp_reading, :diagnosis, :patient_id)
            end
        end
    end
end