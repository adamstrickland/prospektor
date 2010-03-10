# require 'machinist/active_record'
# require 'faker'
# require 'sham'
# 
Sham.define do
  title { Faker::Lorem.words(5).join(' ') }
  name { Faker::Name.name }
  # salutation { Faker::Name.first_name }
  company { Faker::Company.name }
  address { Faker::Address.street_address }
  city(:unique => false) { Faker::Address.city }
  state(:unique => false) { Faker::Address.us_state_abbr }
  zip(:unique => false) { Faker::Address.zip_code }
  body { Faker::Lorem.paragraphs(3).join("\n\n") }
  either(:unique => false){ rand(2) == 0 }
  # url { "#{Faker::Internet.domain_name}/#{Faker::Internet.domain_word}/#{Faker::Lorem.paragraphs(3).join.gsub(' ','')[0..26].split('').map{|c| c[0] }.map{|i| i.to_s.hex}.join}" }
  url { "#{Faker::Internet.domain_name}/#{Faker::Internet.domain_word}" }
  salt(:unique => false) { Digest::SHA1.hexdigest(1.to_s) }
  yesterday(:unique => false) { 1.days.ago }
  tomorrow(:unique => false) { 1.days.from_now }
  password(:unique => false) { User.password_digest('monkey', Sham.salt) }
  email { Faker::Internet.email }
  login { Faker::Internet.user_name }
  last_name(:unique => false) { Faker::Name.last_name }
  first_name { Faker::Name.first_name }
  gender(:unique => false){ rand(2) == 0 ? 'M' : 'F' }
  phone { Faker::PhoneNumber.phone_number.gsub(/\D/, '')[0..9] }
  count(:unique => false) { rand(99) }
  big_count(:unique => false) { rand(50) * 100 }
  huge_count(:unique => false) { rand(99) * 10000 }
  code(:unique => false) { (65..90).to_a.rand.chr }
  sic(:unique => false) { (1..6).to_a.map{|i| rand(9)}.join }
  msa(:unique => false) { (1..3).to_a.map{|i| Faker::Address.city}.join('--') }
  credit_score(:unique => false){ rand(800) }
  client_reference_number{ |index| 288000 + index }
  seq{ |index| index }
end

Lead.blueprint do
  name
  last_name
  first_name
  salutation{ self.first_name }
  title { 'President' }
  gender
  company
  year_established { 2000 }
  address
  city
  state
  zip
  phone
end

Lead.blueprint(:full) do
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
  # credit_rating { 'Excellent' }
  source { 'RefUSA' }
  imported_at { 1.years.ago }
  timezone { 'C' }
  updated_at { Sham.yesterday }
  created_at { Sham.yesterday }
end

Employee.blueprint do
  last_name
  first_name
  middle_initial{ Faker::Name.first_name[0].chr }
  address
  city
  state_or_province{ Sham.state }
  postal_code { Sham.zip }
  business_phone { Sham.phone }
  fax { Sham.phone }
  cellular { Sham.phone }
  phone
  gender
  email_name { Sham.email }
  active { true }
end

Employee.blueprint(:inactive) do
  active { false }
end

User.blueprint do
  login
  name
  email
  salt
  crypted_password { Sham.password }
  created_at { Sham.yesterday }
  activated_at { Sham.yesterday }
  updated_at { Sham.yesterday }
  remember_token_expires_at { Sham.tomorrow }
  remember_token { Sham.salt }
  phone
  extension { rand(9) % 2 == 0 ? '' : (1..3).map{|i| rand(9)}.join }
  mobile { Sham.phone }
end

Sale.blueprint do
  appointment{ Appointment.make }
  client_reference_number
  rep{ Employee.make }
  partner{ Employee.make }
end

Appointment.blueprint do
  lead
  user
  status{ AppointmentStatus.find_by_code('CB') }
  references_requested{ false }
  scheduled_at { Date.today + 1 }
end

Schedule.blueprint do
  contact
  employee
  status{ AppointmentStatus.find_by_code('CB') }
end

Contact.blueprint do
  lead
  bc{ Employee.make }
  analysis_topic{ AnalysisTopic.make }
end

AnalysisTopic.blueprint do
  name{ Faker::Lorem.words(2).join(' ').titleize }
  number{ Sham.seq }
  type{ 'AnalysisTopic' }
end

InformationTopic.blueprint do
  name{ Faker::Lorem.words(2).join(' ').titleize }
  url{ "#{Faker::Internet.domain_name}/#{Faker::Internet.domain_word}" }
  type{ 'InformationTopic' }
end

Applicant.blueprint do
  first_name
  preferred_name{ self.first_name }
  middle_initial{ Faker::Name.first_name[0].chr }
  last_name
  address
  city
  state_province{ Sham.state }
  postal_code{ Sham.zip }
  country{ 'US' }
  email
  home_phone { Sham.phone }
  mobile_phone { Sham.phone }
  business_phone { Sham.phone }
  position_applying_for { 'Sales' }
  years_experience { '0-2 years' }
  consulting_experience_description{ 'Some stuff' }
  has_applied_before{ false }
  how_heard{ 'Craigslist' }
  highest_education { "Bachelor's Degree" }
  school { 'The University of Texas at Austin' }
  has_internet { true }
  has_voip { false }
end

CallBack.blueprint do
  lead
  user
  callback_at{ Chronic.parse("#{Date.tomorrow} 12:00pm") }
end

Presentation.blueprint do
  lead
  user
  email
  topic{ InformationTopic.make }
end

# InformationTopic.blueprint do
#   name{ Faker::Lorem.words(2).join(' ').titleize }
#   type{ 'InformationTopic' }
#   information{ "http://#{Faker::Internet.domain_name}/#{Faker::Lorem.words.join('/').downcase}" }
# end