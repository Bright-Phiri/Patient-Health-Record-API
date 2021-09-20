class CreateVitalSigns < ActiveRecord::Migration[6.1]
  def change
    create_table :vital_signs do |t|
      t.float :weight
      t.float :height
      t.float :temp_reading
      t.string :diagnosis
      t.belongs_to :patient, null: false, foreign_key: true

      t.timestamps
    end
  end
end
