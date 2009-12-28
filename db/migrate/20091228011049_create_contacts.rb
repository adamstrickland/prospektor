class CreateContacts < ActiveRecord::Migration
  def self.up
    create_table :contacts do |t|
      t.integer :id
			t.integer :lead_id
			t.integer :bcid
			t.string :memo
			t.datetime :date
			t.datetime :set_date
			t.datetime :set_time
			t.string :status
			t.datetime :recontact_date
			t.datetime :recontact_time
			t.datetime :appt_date
			t.datetime :appt_time
			t.string :confirmed
			t.string :faxed
			t.string :one_legged
			t.string :rcvd
			t.string :hot_buttons
			t.string :prospect_problems
			t.string :discuss_competition
			t.string :history_&_success
			t.string :knows_bmc
			t.string :bad_experience
			t.string :prior_consultant
			t.string :presentation_scheduled
			t.string :presentation_scheduled_set_with
			t.string :presentation_viewed
			t.string :presentation_score
			t.datetime :expert_date
			t.datetime :expert_time
			t.string :expert_set_with
			t.string :expert_topic
			t.datetime :expert_timeframe
			t.datetime :expert_time_confirmation
			t.datetime :created_at
			t.timestamps
    end
    execute 'CREATE VIEW Contacts ( ContactID,LeadID,BCID,Memo,Date,Set Date,Set Time,Status,Recontact Date,Recontact Time,ApptDate,ApptTime,Confirmed,Faxed,One-Legged,Rcvd,Hot Buttons,Prospect Problems,Discuss Competition,History & Success,Knows BMC,Bad Experience,Prior Consultant,Presentation Scheduled,Presentation Scheduled Set With,Presentation Viewed,Presentation Score,Expert Date,Expert Time,Expert Set With,Expert Topic,Expert Timeframe,Expert Time Confirmation,SSMA_TimeStamp) AS SELECT id,lead_id,bcid,memo,date,set_date,set_time,status,recontact_date,recontact_time,appt_date,appt_time,confirmed,faxed,one_legged,rcvd,hot_buttons,prospect_problems,discuss_competition,history_&_success,knows_bmc,bad_experience,prior_consultant,presentation_scheduled,presentation_scheduled_set_with,presentation_viewed,presentation_score,expert_date,expert_time,expert_set_with,expert_topic,expert_timeframe,expert_time_confirmation,created_at FROM contacts'
  end

  def self.down
    execute 'DROP VIEW Contacts'
    drop_table :contacts
  end
end
