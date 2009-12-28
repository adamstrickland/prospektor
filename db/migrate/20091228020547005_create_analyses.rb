class CreateAnalyses < ActiveRecord::Migration
  def self.up
    create_table :analyses do |t|
      t.integer :id
      t.string :job
      t.string :analyst
      t.string :acs_status
      t.string :mcs_status
      t.string :job_status
      t.string :ran
      t.string :hours_sold
      t.string :project
      t.string :men
      t.datetime :mcs_date
      t.datetime :mcs_time
      t.string :comment
      t.float :pay_rate
      t.string :lcrp_email
      t.timestamps
    end
    execute 'CREATE VIEW `AnalysesView` ( `ID`,`Job .`,`Analyst`,`ACS Status`,`MCS Status`,`Job Status`,`Ran`,`Hours Sold`,`Project`,`Men`,`MCS Date`,`MCS Time`,`Comment`,`PayRate`,`LCRP-Email`) AS SELECT id,job,analyst,acs_status,mcs_status,job_status,ran,hours_sold,project,men,mcs_date,mcs_time,comment,pay_rate,lcrp_email FROM analyses'
  end
  def self.down
    execute 'DROP VIEW `AnalysesView`'
    drop_table :analyses
  end
end