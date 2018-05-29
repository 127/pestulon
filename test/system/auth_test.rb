require 'application_system_test_case'

class AuthTest < ApplicationSystemTestCase
  
  # test 'user login logout with correct details' do
  #   visit root_path
  #   click_link  :class=>'ion-ios-email-outline'
  #   assert_equal new_user_session_path(:locale=>I18n.locale), current_path
  #   expect_fields_to_be_blank
  #
  #   # login
  #   fill_in 'Email',    with: 'a@b.ru'
  #   fill_in 'Password', with: 123321123
  #   click_button I18n.t('shared.links.login')
  #
  #   assert_equal root_path(:locale=>I18n.locale), current_path
  #   assert_text I18n.t('shared.labels.logout')
  #   assert_selector  :xpath, ".//img[@alt='a@b.ru']"
  #   # noeflash message on Index change it if needed
  #   # assert_text I18n.t('devise.sessions.signed_in')
  #
  #   click_link I18n.t('shared.labels.logout')
  #   assert_equal new_user_session_path(:locale=>I18n.locale), current_path
  #   assert_text I18n.t('shared.labels.registration')
  #   assert_text I18n.t('devise.sessions.signed_out')
  #   expect_fields_to_be_blank
  # end
  
  private

    def expect_fields_to_be_blank
      assert_empty find_field('Email', type: 'email').value
      assert_empty find_field('Password', type: 'password', :match => :prefer_exact).value
    end  
  
  # # `js: true` spec metadata means this will run using the `:selenium`
  # # browser driver configured in spec/support/capybara.rb
  # scenario "with correct details", js: true do
  #
  #   create(:user, email: "someone@example.tld", password: "somepassword")
  #
  #   visit "/"
  #
  #   click_link "Log in"
  #   expect(page).to have_css("h2", text: "Log in")
  #   expect(current_path).to eq(new_user_session_path)
  #
  #   login "someone@example.tld", "somepassword"
  #
  #   expect(page).to have_css("h1", text: "Welcome to RSpec Rails Examples")
  #   expect(current_path).to eq "/"
  #   expect(page).to have_content "Signed in successfully"
  #   expect(page).to have_content "Hello, someone@example.tld"
  #
  #   click_button "Log out"
  #
  #   expect(current_path).to eq "/"
  #   expect(page).to have_content "Signed out successfully"
  #   expect(page).not_to have_content "someone@example.tld"
  #
  # end
  #
  # scenario "unconfirmed user cannot login" do
  #
  #   create(:user, skip_confirmation: false, email: "e@example.tld", password: "test-password")
  #
  #   visit new_user_session_path
  #
  #   login "e@example.tld", "test-password"
  #
  #   expect(current_path).to eq(new_user_session_path)
  #   expect(page).not_to have_content "Signed in successfully"
  #   expect(page).to have_content "You have to confirm your email address before continuing"
  # end
  #
  # scenario "locks account after 10 failed attempts" do
  #
  #   email = "someone@example.tld"
  #   create(:user, email: email, password: "somepassword")
  #
  #   visit new_user_session_path
  #
  #   (1..8).each do |attempt_num|
  #     login email, "wrong-password #{attempt_num}"
  #     expect(page).to have_content "Invalid email or password"
  #   end
  #
  #   login email, "wrong-password 9"
  #   expect(page).to have_content "You have one more attempt before your account is locked"
  #
  #   login email, "wrong-password 10"
  #   expect(page).to have_content "Your account is locked."
  #
  # end
  #
  # private
  #
  # def login(email, password)
  #   fill_in "Email", with: email
  #   fill_in "Password", with: password
  #   click_button "Log in"
  # end
  #
  
end