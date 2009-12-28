class CreateAcsCompensationPlanTable < ActiveRecord::Migration
  def self.up
    create_table :acs_compensation_plan do |t|
      t.integer :mcs_override
      t.integer :go_rate
      t.string :jba
      t.timestamps
    end
  end

  def self.down
    drop_table :acs_compensation_plan
  end
end
