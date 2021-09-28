module Api
    module V1
        class VitalSignsController  < ApplicationController
            rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

            def create
                if Patient.where(id: params[:patient_id]).exists?
                    vital_sign = VitalSign.new(vital_signs_params)
                    if vital_sign.save
                      render json: { status: 'success', message: 'Vital signs successfully added to the patient',data: vital_sign}, status: :created
                    else
                      render json: { status: 'error', message: 'Failed to add vital signs to patient', data: vital_sign.errors.full_messages}
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

            def record_not_found
                render json: { status: 'error', message: 'Patient health record not found'}
            end
        end
    end
end