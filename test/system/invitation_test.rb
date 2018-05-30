require 'application_system_test_case'

class InvitationTest < ApplicationSystemTestCase
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
  
  # user A invites user B
  test 'invite new user and accept invite correctly' do
    log_in_and_go_to_invites    
    fill_in 'Email',    with: 'not@existing.user'
    click_button I18n.t('devise.invitations.new.submit_button')
    assert_equal new_user_invitation_path(:locale=>I18n.locale), current_path
    assert_empty find_field('Email', type: 'email').value
    assert_text I18n.t('devise.invitations.send_instructions', email: 'not@existing.user')
    
  end
  
  test 'invite self' do
    log_in_and_go_to_invites
    invite_incorrect_user 'a@b.ru', 'has already been taken'
  end
  
  test 'invite existing user' do
    log_in_and_go_to_invites
    invite_incorrect_user 'b@b.ru', 'has already been taken'
  end
  
  
  test 'invite user with invalid email' do
    log_in_and_go_to_invites
    invite_incorrect_user 'invalid-email-for-testing', 'is invalid'
  end
  
  test 'accept invite' do
  end
  
  test 'accept incorrect invite token' do
    
  end
  
  
  private 
  
    def expect_fields_to_be_blank
      assert_empty find_field('Email',    type: 'email').value
      assert_empty find_field('Password', type: 'password', :match => :prefer_exact).value
    end  
    
    def log_in_and_go_to_invites
      fill_in 'Email',    with: 'a@b.ru'
      fill_in 'Password', with: 123321123
      click_button I18n.t('shared.links.login')
      assert_text I18n.t('shared.labels.logout')
    
      click_link I18n.t('shared.labels.invite')
      assert_equal new_user_invitation_path(:locale=>I18n.locale), current_path
      assert_empty find_field('Email', type: 'email').value
    end
    
    def invite_incorrect_user email, msg
      fill_in 'Email',    with: email
      click_button I18n.t('devise.invitations.new.submit_button')
      assert_equal user_invitation_path(:locale=>I18n.locale), current_path
      assert_selector 'input#user_email+span', text: msg
    end

end