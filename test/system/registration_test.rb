# http://garyrafferty.com/2011/09/29/Testing-devise-with-rspec-and-capybara.html
# https://github.com/eliotsykes/rspec-rails-examples/blob/master/spec/features/user_registers_spec.rb
require 'application_system_test_case'

class RegistrationTest < ApplicationSystemTestCase
  
  test 'creating a user' do
    visit root_path
    click_link I18n.t('shared.labels.registration')
    assert_equal new_user_registration_path(:locale=>I18n.locale), current_path
    expect_fields_to_be_blank 1

    fill_in 'Email', with: 'tester@example.tld'
    fill_in 'Password', with: 'test-password', :match => :prefer_exact
    fill_in 'Password confirmation', with: 'test-password', :match => :prefer_exact
    click_button I18n.t('shared.links.register')

    # check if redirected to login page
    assert_equal new_user_session_path(:locale=>I18n.locale), current_path
    assert_text I18n.t('devise.registrations.signed_up_but_unconfirmed')
    expect_fields_to_be_blank
    
    # check unconfirmed login
    fill_in 'Email',    with: 'tester@example.tld'
    fill_in 'Password', with: 'test-password'
    click_button I18n.t('shared.links.login')
    assert_text I18n.t('devise.failure.unconfirmed')
    expect_fields_to_be_blank

    # check approval link
    open_email('tester@example.tld')
    # can be also done this way
    # links = Nokogiri::HTML(current_email.body).css('a').map {|element| element['href']}.compact
    # visit links.first
    current_email.first(:link, 'Confirm my account').click

    # resdirect link
    assert_equal new_user_session_path(:locale=>I18n.locale), current_path
    assert_text I18n.t('devise.confirmations.confirmed')
    expect_fields_to_be_blank

    # @depracated 
    # moved to aut_test.rb
    #
    # # login
    # fill_in 'Email',    with: 'tester@example.tld'
    # fill_in 'Password', with: 'test-password'
    # click_button I18n.t('shared.links.login')
    #
    # assert_equal root_path(:locale=>I18n.locale), current_path
    # assert_text I18n.t('shared.labels.logout')
    # assert_selector  :xpath, ".//img[@alt='tester@example.tld']"
    # # noeflash message on Index change it if needed
    # # assert_text I18n.t('devise.sessions.signed_in')
    #
    # click_link I18n.t('shared.labels.logout')
    # assert_equal new_user_session_path(:locale=>I18n.locale), current_path
    # assert_text I18n.t('shared.labels.registration')
    # assert_text I18n.t('devise.sessions.signed_out')
    # expect_fields_to_be_blank
  end

  test 'user with blank fields' do
    visit new_user_registration_path
    expect_fields_to_be_blank 1
    click_button I18n.t('shared.links.register')
    # not new_user_registration_path!!!!!!
    assert_equal user_registration_path(:locale=>I18n.locale), current_path
    assert_selector 'input#user_email+span',    text: "can't be blank"
    assert_selector 'input#user_password+span', text: "can't be blank"
    # assert_selector 'input#user_password_confirmation+span', text: "can't be blank"
  end

  test 'user with incorrect password confirmation' do
    visit new_user_registration_path
    expect_fields_to_be_blank 1
    fill_in 'Email', with: 'tester@example.tld'
    fill_in 'Password', with: 'test-password', :match => :prefer_exact
    fill_in 'Password confirmation', with: 'not-test-password', :match => :prefer_exact
    click_button I18n.t('shared.links.register')
    assert_equal user_registration_path(:locale=>I18n.locale), current_path
    assert_selector 'input#user_password_confirmation+span', text: "doesn't match Password"
  end

  test 'user with already registered email' do
    visit new_user_registration_path
    expect_fields_to_be_blank 1
    fill_in 'Email', with: 'a@b.ru'
    fill_in 'Password', with: 123321123, :match => :prefer_exact
    fill_in 'Password confirmation', with: 'test-password', :match => :prefer_exact
    click_button I18n.t('shared.links.register')
    assert_equal user_registration_path(:locale=>I18n.locale), current_path
    assert_selector 'input#user_email+span', text: 'has already been taken'
  end

  test 'user with invalid email' do
    visit new_user_registration_path
    expect_fields_to_be_blank 1
    fill_in 'Email', with: 'invalid-email-for-testing'
    fill_in 'Password', with: 'test-password', :match => :prefer_exact
    fill_in 'Password confirmation', with: 'test-password', :match => :prefer_exact
    click_button I18n.t('shared.links.register')
    assert_equal user_registration_path(:locale=>I18n.locale), current_path
    assert_selector 'input#user_email+span', text: 'is invalid'
  end

  test 'user with too short password' do
    visit new_user_registration_path
    expect_fields_to_be_blank 1
    fill_in 'Email', with: 'tester@example.tld'
    fill_in 'Password', with: '1', :match => :prefer_exact
    fill_in 'Password confirmation', with: '1', :match => :prefer_exact
    click_button I18n.t('shared.links.register')
    assert_equal user_registration_path(:locale=>I18n.locale), current_path
    assert_selector 'input#user_password+span', text: 'is too short (minimum is 8 characters)'
  end 

  private

    def expect_fields_to_be_blank reg=0
      assert_empty find_field('Email', type: 'email').value
      assert_empty find_field('Password', type: 'password', :match => :prefer_exact).value
      assert_empty find_field('Password confirmation', type: 'password', :match => :prefer_exact).value if reg==1
    end
end
