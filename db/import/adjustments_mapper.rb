class AdjustmentsMapper < Pipeline::TransformMapper
  define_mappings({
    'PayAdjustmentID' => { :to => :pay_adjustment_id},'EmpID' => { :to => :emp_id},'Pay Date' => { :to => :pay_date},'Adjustment' => { :to => :adjustment},'Comment' => { :to => :comment}
  })
end
