class Bc Hot ButtonsMapper < Pipeline::TransformMapper
  define_mappings({
    'ID' => { :to => :id},'SIC Division' => { :to => :sic_division},'SIC Group' => { :to => :sic_group},'HB Name' => { :to => :hb_name},'Question 1' => { :to => :question_1},'Question 2' => { :to => :question_2},'Question 3' => { :to => :question_3},'Question 4' => { :to => :question_4},'Question 5' => { :to => :question_5},'Question 6' => { :to => :question_6},'Question 7' => { :to => :question_7},'SSMA_TimeStamp' => { :to => :created_at}
  })
end
