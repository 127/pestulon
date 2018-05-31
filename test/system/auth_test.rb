require 'application_system_test_case'

class AuthTest < ApplicationSystemTestCase
  
  # before every test do
  setup do 
    # go to index page
    visit root_path
    # click sign_in link
    click_link  :class=>'ion-ios-email-outline'
    #check if correct sign_in URL opened
    assert_equal new_user_session_path(:locale=>I18n.locale), current_path
    # check if all sign_in fields are blank
    expect_fields_to_be_blank
  end
  
  test 'user login logout with correct details' do
    fill_form 'a@b.ru', 123321123, I18n.t('shared.labels.logout')
    assert_equal root_path(:locale=>I18n.locale), current_path
    assert_selector  :xpath, ".//img[@alt='a@b.ru']"
    # noeflash message on Index change it if needed
    # assert_text I18n.t('devise.sessions.signed_in')

    click_link I18n.t('shared.labels.logout')
    assert_equal new_user_session_path(:locale=>I18n.locale), current_path
    assert_text I18n.t('shared.labels.registration')
    assert_text I18n.t('devise.sessions.signed_out')
    expect_fields_to_be_blank
  end
  
  test 'unconfirmed user cannot login' do
    fill_form 'unconfirmed@b.ru', 123321123, I18n.t('devise.failure.unconfirmed')
    expect_fields_to_be_blank
  end
  
  test 'locks account after 10 failed attempts' do
    (1..8).each do |i|
      fill_form 'a@b.ru', 123321123+i, 'Invalid Email or password.'
    end
    fill_form 'a@b.ru', 123321123+9,  I18n.t('devise.failure.last_attempt')
    fill_form 'a@b.ru', 123321123+10, I18n.t('devise.failure.locked')
  end
  
  private
  
    def fill_form email, pass, message
      fill_in 'Email',    with: email
      fill_in 'Password', with: pass
      click_button I18n.t('shared.links.login')
      assert_text message
    end

    def expect_fields_to_be_blank
      assert_empty find_field('Email',    type: 'email').value
      assert_empty find_field('Password', type: 'password', :match => :prefer_exact).value
    end  
  
end
