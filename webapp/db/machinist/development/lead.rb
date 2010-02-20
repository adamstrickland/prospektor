require File.join(File.dirname(__FILE__), '..', 'machinist')

Lead.blueprint do
  name
  last_name
  first_name
  title { 'President' }
  gender { Sham.m_or_f }
  company
  year_established { 2000 }
  address
  city
  state
  zip
  phone
  fax { Sham.phone }
  cell_phone { Sham.phone }
  employee_actual { Sham.count }
  employee_code { Sham.code }
  sales_actual { Sham.huge_count }
  sales_code { Sham.code }
  sic_code_1 { Sham.sic }
  sic_description_1 { Faker::Lorem.words(5) }
  msa
  email
  number_of_pcs { Sham.count }
  square_footage { Sham.big_count }
  own_property { Sham.either }
  credit_score
  credit_rating { 'Excellent' }
  source { 'RefUSA' }
  imported_at { 1.years.ago }
  timezone { 'C' }
  updated_at { Sham.yesterday }
  created_at { Sham.yesterday }
  aasm_state { :assigned }
  user { User.find_by_login('adam.strickland') }
end