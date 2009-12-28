class CreatePrior Whos < ActiveRecord::Migration
  def self.up
    create_table :prior_whos do |t|
      t.integer :id
			t.string :prior_who
			t.timestamps
    end
    execute 'CREATE VIEW PriorWho ( ID,PriorWho) AS SELECT id,prior_who FROM prior_whos'
  end

  def self.down
    execute 'DROP VIEW PriorWho'
    drop_table :prior_whos
  end
end
