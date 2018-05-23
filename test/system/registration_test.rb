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
    
    #check if redirected to registration page
    assert_equal new_user_session_path(:locale=>I18n.locale), current_path
    
    # open_email "tester@example.tld", with_subject: "Confirmation instructions"
    # visit_in_email "Confirm my account"
    
    mail = ActionMailer::Base.deliveries.last
    # link = links_in_email(mail)[1]
    # visit link
    p 123
    puts  Devise.mailer.deliveries
    
    # mail.body.find_link("Confirm my account").click_link
  end
end
