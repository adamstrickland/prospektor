class CreateSales < ActiveRecord::Migration
  def self.up
    create_table :sales do |t|
      t.integer :id
			t.integer :appointment_id
			t.string :client_referenc_number
			t.string :booked
			t.string :fee
			t.string :skd
			t.string :skt
			t.string :owner2_name
			t.string :owner2_title
			t.string :owner2%
			t.string :owner3_name
			t.string :owner3_title
			t.string :owner3%
			t.string :focus
			t.integer :rep_id
			t.integer :par_id
			t.string :prior_who
			t.string :prior_when
			t.datetime :prior_what
			t.string :prior_satisfaction
			t.string :emp_l12
			t.string :vol_l12
			t.string :comment
			t.string :confirmed
			t.string :expects
			t.string :business_description
			t.string :location
			t.datetime :created_at
			t.timestamps
    end
    execute 'CREATE VIEW Sales ( SalesID,AppointmentID,ClientReferencNumber,Booked,Fee,Skd,Skt,Owner2Name,Owner2Title,Owner2%,Owner3Name,Owner3Title,Owner3%,Focus,RepID,ParID,PriorWho,PriorWhen,PriorWhat,PriorSatisfaction,EmpL12,VolL12,Comment,Confirmed,Expects,Business Description,Location,SSMA_TimeStamp) AS SELECT id,appointment_id,client_referenc_number,booked,fee,skd,skt,owner2_name,owner2_title,owner2%,owner3_name,owner3_title,owner3%,focus,rep_id,par_id,prior_who,prior_when,prior_what,prior_satisfaction,emp_l12,vol_l12,comment,confirmed,expects,business_description,location,created_at FROM sales'
  end

  def self.down
    execute 'DROP VIEW Sales'
    drop_table :sales
  end
end
