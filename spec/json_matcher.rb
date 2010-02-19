require 'active_support/json'

module JSONMatcher
  def be_json_eql(expected)
    # ActiveSupport::JSON.decode(response.body) == ActiveSupport::JSON.decode(expected)
    ActiveSupport::JSON.decode(expected)
  end
end