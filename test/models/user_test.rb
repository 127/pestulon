require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test "should not save user without email" do
    user = User.new
    assert_not user.save, "Saved the user without an email"
  end
  
end

# describe User do
#
#   before(:each) { @user = User.new(email: 'user@example.com') }
#
#   subject { @user }
#
#   it { should respond_to(:email) }
#
#   it "#email returns a string" do
#     expect(@user.email).to match 'user@example.com'
#   end
#
# end