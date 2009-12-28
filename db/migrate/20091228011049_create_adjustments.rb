class CreateAdjustments < ActiveRecord::Migration
  def self.up
    create_table :adjustments do |t|
      t.integer :pay_adjustment_id
			t.integer :emp_id
			t.datetime :pay_date
			t.string :adjustment
			t.string :comment
			t.timestamps
    end
    execute 'CREATE VIEW Adjustment ( PayAdjustmentID,EmpID,Pay Date,Adjustment,Comment) AS SELECT pay_adjustment_id,emp_id,pay_date,adjustment,comment FROM adjustments'
  end

  def self.down
    execute 'DROP VIEW Adjustment'
    drop_table :adjustments
  end
end
