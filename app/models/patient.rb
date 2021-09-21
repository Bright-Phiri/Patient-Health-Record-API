class Patient < ApplicationRecord
    has_many :vital_signs, dependent: :destroy
    validates :first_name, :last_name, :gender, :dob, :district, :village, :occupation, presence: true
    
    after_validation :capitalize_names , on: [:create, :update]

    default_scope {order(dob: :desc)}

    scope :find_by_first_name,->(first_name){ where(first_name: first_name).take!}
    scope :find_by_last_name,->(last_name){ where(last_name: last_name).take!}
    scope :find_by_first_occupation,->(occupation){ find_by(occupation: occupation)}
    scope :find_by_gender,->(gender){ find_by(gender: gender)}
  
    private
    def capitalize_names
        self.first_name = first_name.capitalize
        self.last_name = last_name.capitalize
    end

end
