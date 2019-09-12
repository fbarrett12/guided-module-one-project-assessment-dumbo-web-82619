class CreateAppointments < ActiveRecord::Migration[5.2]
  def change
    create_table :appointments do |t|
      t.integer :customer_id
      t.integer :hairdresser_id
      t.string :date
      t.string :time
    end
  end
end
