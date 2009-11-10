require 'test_helper'

class ProspectMailerTest < ActionMailer::TestCase
  test "invite" do
    @expected.subject = 'ProspectMailer#invite'
    @expected.body    = read_fixture('invite')
    @expected.date    = Time.now

    assert_equal @expected.encoded, ProspectMailer.create_invite(@expected.date).encoded
  end

  test "schedule" do
    @expected.subject = 'ProspectMailer#schedule'
    @expected.body    = read_fixture('schedule')
    @expected.date    = Time.now

    assert_equal @expected.encoded, ProspectMailer.create_schedule(@expected.date).encoded
  end

end
