require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  setup do
    @user = User.new(email: 'foo@example.com', first_name: 'Foo')
  end

  test 'send_invoice' do
    mail = UserMailer.with(user: @user, duration: 12.months, amount_due: 100.0).send_invoice
    assert_equal 'Your Plato Invoice', mail.subject
    assert_equal ['foo@example.com'], mail.to
    assert_equal ['no-reply@plato.com'], mail.from
    assert_match 'Hi Foo, your amount due for 12 months is $100.00', mail.body.encoded
  end
end
