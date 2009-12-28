class CreatePriorConsultings < ActiveRecord::Migration
  def self.up
    create_table :prior_consultings do |t|
      t.integer :id
      t.string :bad_experience
      t.timestamps
    end
    execute 'CREATE VIEW `Prior Consulting` ( `ID`,`Bad Experience`) AS SELECT id,bad_experience FROM prior_consultings'
  end
  def self.down
    execute 'DROP VIEW `Prior Consulting`'
    drop_table :prior_consultings
  end
end