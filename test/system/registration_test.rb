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
    fill_in "Email",    with: "tester@example.tld"
    fill_in "Password", with: "test-password"
    # click_on class: 'ion-ios-email-outline'
    click_button I18n.t('shared.links.login')

    assert_equal root_path(:locale=>I18n.locale), current_path
    assert_text I18n.t('shared.labels.logout')
    assert_selector  :xpath, ".//img[@alt='tester@example.tld']"
    # noeflash message on title change it if needed
    # assert_text I18n.t('devise.sessions.signed_in')
    
    click_link I18n.t('shared.labels.logout')
    assert_equal new_user_session_path(:locale=>I18n.locale), current_path
    assert_text I18n.t('shared.labels.registration')
    assert_text I18n.t('devise.sessions.signed_out')
   
  end
  
  
  #TODO
  context "with invalid details" do

    # before do
    #   visit new_user_registration_path
    # end
    #
    # scenario "blank fields" do
    #
    #   expect_fields_to_be_blank
    #
    #   click_button "Sign up"
    #
    #   expect(page).to have_error_messages "Email can't be blank",
    #     "Password can't be blank"
    # end
    #
    # scenario "incorrect password confirmation" do
    #
    #   fill_in "Email", with: "tester@example.tld"
    #   fill_in "Password", with: "test-password"
    #   fill_in "Password confirmation", with: "not-test-password"
    #   click_button "Sign up"
    #
    #   expect(page).to have_error_message "Password confirmation doesn't match Password"
    # end
    #
    # scenario "already registered email" do
    #
    #   create(:user, email: "dave@example.tld")
    #
    #   fill_in "Email", with: "dave@example.tld"
    #   fill_in "Password", with: "test-password"
    #   fill_in "Password confirmation", with: "test-password"
    #   click_button "Sign up"
    #
    #   expect(page).to have_error_message "Email has already been taken"
    # end
    #
    # scenario "invalid email" do
    #
    #   fill_in "Email", with: "invalid-email-for-testing"
    #   fill_in "Password", with: "test-password"
    #   fill_in "Password confirmation", with: "test-password"
    #   click_button "Sign up"
    #
    #   expect(page).to have_error_message "Email is invalid"
    # end
    #
    # scenario "too short password" do
    #
    #   min_password_length = 8
    #   too_short_password = "p" * (min_password_length - 1)
    #   fill_in "Email", with: "someone@example.tld"
    #   fill_in "Password", with: too_short_password
    #   fill_in "Password confirmation", with: too_short_password
    #   click_button "Sign up"
    #
    #   expect(page).to have_error_message "Password is too short (minimum is 8 characters)"
    # end

  end

  private

  def expect_fields_to_be_blank
    # expect(page).to have_field("Email", with: "", type: "email")
    # # These password fields don't have value attributes in the generated HTML,
    # # so with: syntax doesn't work.
    # expect(find_field("Password", type: "password").value).to be_nil
    # expect(find_field("Password confirmation", type: "password").value).to be_nil
  end
end
