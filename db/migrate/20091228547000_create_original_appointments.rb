class CreateOriginalAppointments < ActiveRecord::Migration
  def self.up
    create_table :schedules do |t|
      t.integer :id
      t.integer :contact_id
      t.datetime :cb_date
      t.datetime :cb_time
      t.string :cb_sale_probability
      t.string :comments
      t.string :appt_status
      t.string :entered
      t.string :closes_attempted
      t.string :call_first
      t.integer :rep_id
      t.string :teleconference
      t.string :pre_appointment
      t.string :e_mailsent
      t.string :lettersent
      t.string :cooperative
      t.string :references_requested
      t.string :maintain_contact
      t.string :online_meeting
      t.datetime :time_start
      t.datetime :time_end
      t.string :no_sale_reason
      t.string :problem1
      t.string :impact1
      t.string :problem2
      t.string :impact2
      t.string :problem3
      t.string :impact3
      t.datetime :probable_acs_date
      t.datetime :probable_sale_date
      t.timestamps
    end
    execute 'CREATE VIEW `AppointmentsView` ( `AppointmentID`,`ContactID`,`CB Date`,`CB Time`,`CB Sale Probability`,`Comments`,`ApptStatus`,`Entered`,`Closes Attempted`,`Call First`,`RepID`,`Teleconference`,`Pre-Appointment`,`e-mailsent`,`Lettersent`,`Cooperative`,`References Requested`,`Maintain Contact`,`Online Meeting`,`TimeStart`,`TimeEnd`,`NoSaleReason`,`Problem1`,`Impact1`,`Problem2`,`Impact2`,`Problem3`,`Impact3`,`Probable ACS Date`,`Probable Sale Date`) AS SELECT id,contact_id,cb_date,cb_time,cb_sale_probability,comments,appt_status,entered,closes_attempted,call_first,rep_id,teleconference,pre_appointment,e_mailsent,lettersent,cooperative,references_requested,maintain_contact,online_meeting,time_start,time_end,no_sale_reason,problem1,impact1,problem2,impact2,problem3,impact3,probable_acs_date,probable_sale_date FROM schedules'
  end
  def self.down
    execute 'DROP VIEW `AppointmentsView`'
    drop_table :appointments
  end
end