require 'machinist/active_record'
require 'faker'
require 'sham'

Sham.define do
  title { Faker::Lorem.words(5).join(' ') }
  name { Faker::Name.name }
  company { Faker::Company.name }
  address { Faker::Address.street_address }
  city { Faker::Address.city }
  state { Faker::Address.us_state_abbr }
  zip { Faker::Address.zip_code }
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
  last_name { Faker::Name.last_name }
  first_name { Faker::Name.first_name }
  m_or_f(:unique => false){ rand(2) == 0 ? 'M' : 'F' }
  phone { Faker::PhoneNumber.phone_number.gsub(/\D/, '')[0..9] }
  count(:unique => false) { rand(99) }
  big_count(:unique => false) { rand(50) * 100 }
  huge_count(:unique => false) { rand(99) * 10000 }
  code(:unique => false) { (65..90).to_a.rand.chr }
  sic(:unique => false) { (1..6).to_a.map{|i| rand(9)}.join }
  msa(:unique => false) { (1..3).to_a.map{|i| Faker::Address.city}.join('--') }
  credit_score(:unique => false){ rand(800) }
end

Appointment.blueprint do
  lead
  scheduler { User.make }
  client_email { Sham.email }
  expert_email { Sham.email }
  location { Faker::Address.street_address }
  duration { 1 }
  topic
  session_date { 1.days.from_now }
  session_time { Time.now.strftime("%I:%M%p") }
end

Comment.blueprint do
  lead
  user
  comment { Faker::Lorem.paragraph }
end

Event.blueprint do
  lead
  user
  action { 'Something' }
  type { 'Foo' }
end

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
  user
end

Lead.blueprint(:assigned) do
  aasm_state { :assigned }
end

Lead.blueprint(:free) do
  aasm_state { :free }
  user { nil }
end

Presentation.blueprint do
  lead
  user
  url
  email
end

Topic.blueprint do
  name { Faker::Company.bs }
  complimentary { true }
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

CallQueue.blueprint do
  name
  user
  queue_date { Date.today }
end

def make_queue_with_leads(attribs={})
  CallQueue.make(attribs) do |q|
    3.times { q.leads.make }
  end
end