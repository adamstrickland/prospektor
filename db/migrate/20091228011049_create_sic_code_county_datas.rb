class CreateSic Code County Datas < ActiveRecord::Migration
  def self.up
    create_table :sic_code_county_datas do |t|
      t.string :sic_code
			t.string :state
			t.string :county
			t.integer :count_of_lead_id
			t.string :count_of_county
			t.integer :sum_of_count_of_lead_id
			t.string :t_emp2
			t.string :t_emp3
			t.string :t_emp4
			t.string :t_emp5
			t.string :t_emp6
			t.string :t_emp7
			t.string :temp8
			t.string :t_vol3
			t.string :t_vol4
			t.string :t_vol5
			t.string :t_vol6
			t.string :t_vol7
			t.string :t_vol8
			t.string :t_credit_e
			t.string :t_credit_vg
			t.string :t_credit_g
			t.datetime :created_at
			t.timestamps
    end
    execute 'CREATE VIEW SIC Code County Data ( SIC Code,State,County,CountOfLeadID,CountOfCounty,SumOfCountOfLeadID,TEmp2,TEmp3,TEmp4,TEmp5,TEmp6,TEmp7,Temp8,TVol3,TVol4,TVol5,TVol6,TVol7,TVol8,TCreditE,TCreditVG,TCreditG,SSMA_TimeStamp) AS SELECT sic_code,state,county,count_of_lead_id,count_of_county,sum_of_count_of_lead_id,t_emp2,t_emp3,t_emp4,t_emp5,t_emp6,t_emp7,temp8,t_vol3,t_vol4,t_vol5,t_vol6,t_vol7,t_vol8,t_credit_e,t_credit_vg,t_credit_g,created_at FROM sic_code_county_datas'
  end

  def self.down
    execute 'DROP VIEW SIC Code County Data'
    drop_table :sic_code_county_datas
  end
end
