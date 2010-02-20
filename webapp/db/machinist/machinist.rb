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