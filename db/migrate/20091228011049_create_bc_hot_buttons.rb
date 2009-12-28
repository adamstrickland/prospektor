class CreateBc Hot Buttons < ActiveRecord::Migration
  def self.up
    create_table :bc_hot_buttons do |t|
      t.integer :id
			t.string :sic_division
			t.string :sic_group
			t.string :hb_name
			t.string :question_1
			t.string :question_2
			t.string :question_3
			t.string :question_4
			t.string :question_5
			t.string :question_6
			t.string :question_7
			t.datetime :created_at
			t.timestamps
    end
    execute 'CREATE VIEW BC Hot Buttons ( ID,SIC Division,SIC Group,HB Name,Question 1,Question 2,Question 3,Question 4,Question 5,Question 6,Question 7,SSMA_TimeStamp) AS SELECT id,sic_division,sic_group,hb_name,question_1,question_2,question_3,question_4,question_5,question_6,question_7,created_at FROM bc_hot_buttons'
  end

  def self.down
    execute 'DROP VIEW BC Hot Buttons'
    drop_table :bc_hot_buttons
  end
end
