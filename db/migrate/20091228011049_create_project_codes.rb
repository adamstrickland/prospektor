class CreateProject Codes < ActiveRecord::Migration
  def self.up
    create_table :project_codes do |t|
      t.integer :project_code_id
			t.string :project
			t.string :description
			t.timestamps
    end
    execute 'CREATE VIEW Project Codes ( ProjectCodeID,Project,Description) AS SELECT project_code_id,project,description FROM project_codes'
  end

  def self.down
    execute 'DROP VIEW Project Codes'
    drop_table :project_codes
  end
end
