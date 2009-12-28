class CreateAppointment Statuses < ActiveRecord::Migration
  def self.up
    create_table :appointment_statuses do |t|
      t.integer :appointment_status_id
			t.string :appointment_code
			t.string :appointment_status_description
			t.string :bc_contacts
			t.string :sales_appt_codes
			t.string :tele_sales_codes
			t.datetime :created_at
			t.timestamps
    end
    execute 'CREATE VIEW Appointment Status ( AppointmentStatusID,AppointmentCode,AppointmentStatusDescription,BC Contacts,Sales Appt Codes,TeleSales Codes,SSMA_TimeStamp) AS SELECT appointment_status_id,appointment_code,appointment_status_description,bc_contacts,sales_appt_codes,tele_sales_codes,created_at FROM appointment_statuses'
  end

  def self.down
    execute 'DROP VIEW Appointment Status'
    drop_table :appointment_statuses
  end
end
