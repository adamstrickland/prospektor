require 'test_helper'

class ApplicationHelperTest < ActiveSupport::TestCase
  include ApplicationHelper
  
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
  
  test 'image_url' do
    source = 'foo'
    host = "http://localhost:8080"
    assertEquals "#{host}/images/#{source}.jpg", image_url(source)
  end
end
