module ExceptionHandler 
    extend ActiveSupport::Concern

    included do
        rescue_from ActiveRecord::RecordNotFound do
            render json: { status: 'error', message: 'Record not found'}
        end
    end
end