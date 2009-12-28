class CreateAppointmentStatuses < ActiveRecord::Migration
  def self.up
    create_table :appointment_statuses do |t|
      t.integer :appointment_status_id
      t.string :appointment_code
      t.string :appointment_status_description
      t.string :bc_contacts
      t.string :sales_appt_codes
      t.string :tele_sales_codes
      t.timestamps
    end
    execute 'CREATE VIEW `Appointment Status` ( `AppointmentStatusID`,`AppointmentCode`,`AppointmentStatusDescription`,`BC Contacts`,`Sales Appt Codes`,`TeleSales Codes`) AS SELECT appointment_status_id,appointment_code,appointment_status_description,bc_contacts,sales_appt_codes,tele_sales_codes FROM appointment_statuses'
  end
  def self.down
    execute 'DROP VIEW `Appointment Status`'
    drop_table :appointment_statuses
  end
end