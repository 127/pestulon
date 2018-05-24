# http://garyrafferty.com/2011/09/29/Testing-devise-with-rspec-and-capybara.html
# https://github.com/eliotsykes/rspec-rails-examples/blob/master/spec/features/user_registers_spec.rb
require 'application_system_test_case'

class UsersTest < ApplicationSystemTestCase
  
  test 'creating a user' do
  
    visit '/'

    click_link 'Sign up'
    assert_equal new_user_registration_path(:locale=>I18n.locale), current_path

    fill_in 'Email', with: 'tester@example.tld'
    fill_in 'Password', with: 'test-password', :match => :prefer_exact
    fill_in 'Password confirmation', with: 'test-password', :match => :prefer_exact
    click_button 'Register'
    
    #check if redirected to registration page
    assert_equal new_user_session_path(:locale=>I18n.locale), current_path
    assert_text I18n.t('devise.registrations.signed_up_but_unconfirmed')
    
    open_email('tester@example.tld')
    links = Nokogiri::HTML(current_email.body).css('a').map {|element| element["href"]}.compact
    visit links.first
    # current_email.first(:link, 'Confirm my account').click
    # puts link.href
    # visit current_email.first(:link, 'Confirm my account')
    
    assert_equal new_user_session_path(:locale=>I18n.locale), current_path
    assert_text I18n.t('devise.confirmations.confirmed') 
    
  end
end
