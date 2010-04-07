require 'spec_helper'

describe Video do
  before(:each) do
    @valid_attributes = {
      :name => Faker::Lorem.words(2).join(' ').titleize,
      :url => "#{Faker::Internet.domain_name}/#{Faker::Internet.domain_word}"
    }
  end

  it "should create a new instance given valid attributes" do
    Video.create!(@valid_attributes)
  end
end
