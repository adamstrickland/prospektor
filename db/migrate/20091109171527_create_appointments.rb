class CreateAppointments < ActiveRecord::Migration
  def self.up
    create_table :appointments do |t|
      t.string :client_email, :null => false
      t.string :expert_email, :null => false
      t.string :location, :null => false
      t.float :duration, :null => false, :default => 1
      t.string :subject, :null => false
      t.text :notes
      t.date :session_date, :null => false
      t.time :session_time, :null => false
      t.references :lead, :null => false
      t.references :scheduler, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :appointments
  end
end
