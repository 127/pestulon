# http://garyrafferty.com/2011/09/29/Testing-devise-with-rspec-and-capybara.html
# https://github.com/eliotsykes/rspec-rails-examples/blob/master/spec/features/user_registers_spec.rb
require 'application_system_test_case'
 
class UsersTest < ApplicationSystemTestCase
  test 'creating a user' do
    # visit new_user_registration
    #
    # click_on 'New Test'
    #
    # fill_in 'Title', with: 'Creating an Article'
    # fill_in 'Body', with: 'Created this article successfully!'
    #
    # click_on 'Create Article'
    #
    # assert_text 'Creating an Article'
  
    visit '/'

    click_link 'Sign up'
    
    assert_equal new_user_registration_path(:locale=>I18n.locale), current_path

    fill_in 'Email', with: 'tester@example.tld'
    fill_in 'Password', with: 'test-password', :match => :prefer_exact
    fill_in 'Password confirmation', with: 'test-password', :match => :prefer_exact
    
    click_button 'Register'
    
    assert_equal '/', current_path
    
  end
end
