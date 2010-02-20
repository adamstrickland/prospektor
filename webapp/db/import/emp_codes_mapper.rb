class EmpCodesMapper < Pipeline::TransformMapper
  define_mappings({
    'Emp Code' => { :to => :emp_code},
    'Employee Size' => { :to => :employee_size},
    'RefUSA Employee Size' => { :to => :ref_usa_employee_size},
  })
end