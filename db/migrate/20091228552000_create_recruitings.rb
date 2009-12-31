class CreateRecruitings < ActiveRecord::Migration
  def self.up
    create_table :recruitings do |t|
      t.integer :applicant_id
      t.datetime :response_date
      t.datetime :response_time
      t.string :ad_city
      t.string :applicant_name
      t.string :phone
      t.string :screener
      t.datetime :screening_date
      t.string :screening_evaluation
      t.string :resume
      t.string :tis
      t.string :interviewer
      t.datetime :interview_date
      t.datetime :interview_time
      t.string :interview_hotel
      t.string :interview_evaluation
      t.string :pie
      t.string :trainer
      t.datetime :training_date
      t.string :training_evaluation
      t.string :comment
      t.string :keirsey
      t.timestamps
    end
    execute 'CREATE VIEW `Recruiting` ( `Applicant ID`,`Response Date`,`Response Time`,`Ad City`,`Applicant Name`,`Phone`,`Screener`,`Screening Date`,`Screening Evaluation`,`Resume`,`TIS`,`Interviewer`,`Interview Date`,`Interview Time`,`Interview Hotel`,`Interview Evaluation`,`PIE`,`Trainer`,`Training Date`,`Training Evaluation`,`Comment`,`Keirsey`) AS SELECT applicant_id,response_date,response_time,ad_city,applicant_name,phone,screener,screening_date,screening_evaluation,resume,tis,interviewer,interview_date,interview_time,interview_hotel,interview_evaluation,pie,trainer,training_date,training_evaluation,comment,keirsey FROM recruitings'
  end
  def self.down
    execute 'DROP VIEW `Recruiting`'
    drop_table :recruitings
  end
end