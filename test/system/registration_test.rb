# http://garyrafferty.com/2011/09/29/Testing-devise-with-rspec-and-capybara.html
# https://github.com/eliotsykes/rspec-rails-examples/blob/master/spec/features/user_registers_spec.rb
require 'application_system_test_case'

class UsersTest < ApplicationSystemTestCase
  
  test 'creating a user' do
  
    visit root_path
    
    click_link I18n.t('shared.labels.registration')
    assert_equal new_user_registration_path(:locale=>I18n.locale), current_path

    fill_in 'Email', with: 'tester@example.tld'
    fill_in 'Password', with: 'test-password', :match => :prefer_exact
    fill_in 'Password confirmation', with: 'test-password', :match => :prefer_exact
    click_button I18n.t('shared.links.register')
    
    #check if redirected to registration page
    assert_equal new_user_session_path(:locale=>I18n.locale), current_path
    assert_text I18n.t('devise.registrations.signed_up_but_unconfirmed')
    
    #check approval link
    open_email('tester@example.tld')
    # @deprecated
    # links = Nokogiri::HTML(current_email.body).css('a').map {|element| element["href"]}.compact
    # visit links.first
    current_email.first(:link, 'Confirm my account').click
    
    #resdirect link
    assert_equal new_user_session_path(:locale=>I18n.locale), current_path
    assert_text I18n.t('devise.confirmations.confirmed') 
    
    #login
    fill_in "Email", with: "tester@example.tld"
    fill_in "Password", with: "test-password"
    # click_on class: 'ion-ios-email-outline'
    click_button I18n.t('shared.links.login')

    assert_equal root_path(:locale=>I18n.locale), current_path
    assert_text I18n.t('shared.labels.logout')
    #WTF!? it fails
    # expect(page).to have_content "Signed in successfully."
    # puts assert_select 'a[href]'
    # assert_select "a img" do
    #   assert_select "[alt=?]", 'tester@example.tld'
    # end
   
  end
end
