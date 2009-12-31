class CreateQuestionsForSicCode7532s < ActiveRecord::Migration
  def self.up
    create_table :questions_for_sic_code_7532s do |t|
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
      t.timestamps
    end
    execute 'CREATE VIEW `Questions for SIC Code 7532` ( `SIC Division`,`SIC Code`,`Q01`,`Q02`,`Q03`,`Q04`,`Q05`,`Q06`,`Q07`,`Q08`,`Q09`,`Q10`,`Q11`,`Q12`,`Q13`,`Q14`,`Q15`,`Q16`,`Q17`,`Q18`,`Q19`,`Q20`,`Q21`,`Q22`,`Q23`,`Q24`,`Q25`,`Q26`,`Q27`,`Q28`,`Q29`,`Q30`,`Q31`,`Q32`,`Q33`,`Q34`,`Q35`,`Q36`) AS SELECT sic_division,sic_code,q01,q02,q03,q04,q05,q06,q07,q08,q09,q10,q11,q12,q13,q14,q15,q16,q17,q18,q19,q20,q21,q22,q23,q24,q25,q26,q27,q28,q29,q30,q31,q32,q33,q34,q35,q36 FROM questions_for_sic_code_7532s'
  end
  def self.down
    execute 'DROP VIEW `Questions for SIC Code 7532`'
    drop_table :questions_for_sic_code_7532s
  end
end