class Patient < ApplicationRecord
    has_many :vital_signs, dependent: :destroy
    validates :first_name, :last_name, :gender, :dob, :district, :village, :occupation, presence: true
    
    after_validation :capitalize_names , on: [:create, :update]

    default_scope {order(dob: :desc)}

    scope :male_patients,->{where(gender: 'Male')}
    scope :female_patients,->{where(gender: 'Female')}
  
    private
    def capitalize_names
        self.first_name = first_name.capitalize
        self.last_name = last_name.capitalize
    end

end
