class CreateStateSicEmpVolStats < ActiveRecord::Migration
  def self.up
    create_table :state_sic_emp_vol_stats do |t|
      t.string :state
      t.string :sic_code
      t.string :emp_u
      t.string :emp1
      t.string :emp2
      t.string :emp3
      t.string :emp4
      t.string :emp5
      t.string :emp6
      t.string :emp7
      t.string :emp8
      t.string :vol_u
      t.string :vol1
      t.string :vol2
      t.string :vol3
      t.string :vol4
      t.string :vol5
      t.string :vol6
      t.string :vol7
      t.string :vol8
      t.datetime :updated
      t.timestamps
    end
    execute 'CREATE VIEW `State SIC Emp-Vol Stats` ( `State`,`SIC Code`,`EmpU`,`Emp1`,`Emp2`,`Emp3`,`Emp4`,`Emp5`,`Emp6`,`Emp7`,`Emp8`,`VolU`,`Vol1`,`Vol2`,`Vol3`,`Vol4`,`Vol5`,`Vol6`,`Vol7`,`Vol8`,`Updated`) AS SELECT state,sic_code,emp_u,emp1,emp2,emp3,emp4,emp5,emp6,emp7,emp8,vol_u,vol1,vol2,vol3,vol4,vol5,vol6,vol7,vol8,updated FROM state_sic_emp_vol_stats'
  end
  def self.down
    execute 'DROP VIEW `State SIC Emp-Vol Stats`'
    drop_table :state_sic_emp_vol_stats
  end
end