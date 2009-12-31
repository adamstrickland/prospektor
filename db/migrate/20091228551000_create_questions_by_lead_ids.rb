class CreateQuestionsByLeadIds < ActiveRecord::Migration
  def self.up
    create_table :questions_by_lead_ids do |t|
      t.integer :lead_id
      t.string :sic_division
      t.string :sic_code
      t.string :q01
      t.string :q02
      t.string :q03
      t.string :q04
      t.string :q05
      t.string :q06
      t.string :q07
      t.string :q08
      t.string :q09
      t.string :q10
      t.string :q11
      t.string :q12
      t.string :q13
      t.string :q14
      t.string :q15
      t.string :q16
      t.string :q17
      t.string :q18
      t.string :q19
      t.string :q20
      t.string :q21
      t.string :q22
      t.string :q23
      t.string :q24
      t.string :q25
      t.string :q26
      t.string :q27
      t.string :q28
      t.string :q29
      t.string :q30
      t.string :q31
      t.string :q32
      t.string :q33
      t.string :q34
      t.string :q35
      t.string :q36
      t.string :question_1
      t.string :question_2
      t.string :question_3
      t.string :question_4
      t.string :question_5
      t.string :question_6
      t.string :question_7
      t.string :question_8
      t.string :question_9
      t.string :question_10
      t.string :question_11
      t.string :question_12
      t.string :question_13
      t.string :question_14
      t.string :question_15
      t.string :question_16
      t.string :question_17
      t.string :question_18
      t.string :question_19
      t.string :question_20
      t.string :question_21
      t.string :question_22
      t.string :question_23
      t.string :question_24
      t.string :question_25
      t.string :question_26
      t.string :question_27
      t.string :question_28
      t.string :question_29
      t.string :question_30
      t.string :question_31
      t.string :question_32
      t.string :question_33
      t.string :question_34
      t.string :question_35
      t.string :question_36
      t.string :question_99
      t.string :question_100
      t.timestamps
    end
    execute 'CREATE VIEW `Questions by LeadID` ( `LeadID`,`SIC Division`,`SIC Code`,`Q01`,`Q02`,`Q03`,`Q04`,`Q05`,`Q06`,`Q07`,`Q08`,`Q09`,`Q10`,`Q11`,`Q12`,`Q13`,`Q14`,`Q15`,`Q16`,`Q17`,`Q18`,`Q19`,`Q20`,`Q21`,`Q22`,`Q23`,`Q24`,`Q25`,`Q26`,`Q27`,`Q28`,`Q29`,`Q30`,`Q31`,`Q32`,`Q33`,`Q34`,`Q35`,`Q36`,`Question 1`,`Question 2`,`Question 3`,`Question 4`,`Question 5`,`Question 6`,`Question 7`,`Question 8`,`Question 9`,`Question 10`,`Question 11`,`Question 12`,`Question 13`,`Question 14`,`Question 15`,`Question 16`,`Question 17`,`Question 18`,`Question 19`,`Question 20`,`Question 21`,`Question 22`,`Question 23`,`Question 24`,`Question 25`,`Question 26`,`Question 27`,`Question 28`,`Question 29`,`Question 30`,`Question 31`,`Question 32`,`Question 33`,`Question 34`,`Question 35`,`Question 36`,`Question 99`,`Question 100`) AS SELECT lead_id,sic_division,sic_code,q01,q02,q03,q04,q05,q06,q07,q08,q09,q10,q11,q12,q13,q14,q15,q16,q17,q18,q19,q20,q21,q22,q23,q24,q25,q26,q27,q28,q29,q30,q31,q32,q33,q34,q35,q36,question_1,question_2,question_3,question_4,question_5,question_6,question_7,question_8,question_9,question_10,question_11,question_12,question_13,question_14,question_15,question_16,question_17,question_18,question_19,question_20,question_21,question_22,question_23,question_24,question_25,question_26,question_27,question_28,question_29,question_30,question_31,question_32,question_33,question_34,question_35,question_36,question_99,question_100 FROM questions_by_lead_ids'
  end
  def self.down
    execute 'DROP VIEW `Questions by LeadID`'
    drop_table :questions_by_lead_ids
  end
end