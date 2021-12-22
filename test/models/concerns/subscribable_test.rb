require 'test_helper'

class ConcernSubscribableTest < ActiveSupport::TestCase
  setup do
    @obj_struct = Struct.new(:subscription_type) { include Subscribable }
  end

  test 'returns correct subscription class' do
    obj = @obj_struct.new('solo')
    assert_equal Subscription::Solo, obj.subscription_class

    obj = @obj_struct.new('startup')
    assert_equal Subscription::Startup, obj.subscription_class

    obj = @obj_struct.new('business')
    assert_equal Subscription::Business, obj.subscription_class
  end
end
