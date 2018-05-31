require 'application_system_test_case'

class InvitationTest < ApplicationSystemTestCase
  # before every test do
  setup do 
    # go to index page
    visit root_path
    # click sign_in link
    click_link  :class=>'ion-ios-email-outline'
    # check if correct sign_in URL opened
    assert_equal new_user_session_path(:locale=>I18n.locale), current_path
    # check if all sign_in fields are blank
    expect_fields_to_be_blank
    
    # login 
    fill_in 'Email',    with: 'a@b.ru'
    fill_in 'Password', with: 123321123
    click_button I18n.t('shared.links.login')
    assert_text I18n.t('shared.labels.logout')
    
    # go to invite page
    click_link I18n.t('shared.labels.invite')
    assert_equal new_user_invitation_path(:locale=>I18n.locale), current_path
    assert_empty find_field('Email', type: 'email').value
  end
  
  # user A invites user B
  test 'invite new user and accept invite correctly' do 
    invite_correct_user_and_logout
    
    # check approval link
    open_email('not@existing.user')
    current_email.first(:link, 'Accept invitation').click
    
    # donno why link doesn;t have scope (:locale=>I18n.locale)
    assert_equal accept_user_invitation_path, current_path
    assert_empty find_field('Password', type: 'password', :match => :prefer_exact).value
    assert_empty find_field('Password confirmation', type: 'password', :match => :prefer_exact).value
    
    # change password
    
  end
  
  test 'invite self' do
    invite_incorrect_user_and_logout 'a@b.ru', 'has already been taken'
  end
  
  test 'invite existing user' do
    invite_incorrect_user_and_logout 'b@b.ru', 'has already been taken'
  end
  
  
  test 'invite user with invalid email' do
    invite_incorrect_user_and_logout 'invalid-email-for-testing', 'is invalid'
  end
  
  test 'accept incorrect invite token' do
    invite_correct_user_and_logout 

    open_email('not@existing.user')
    visit current_email.first(:link)[:href].gsub /invitation_token=(.*)/, 'invitation_token=not-existing-token'
    
    assert_equal new_user_session_path(:locale=>I18n.locale), current_path
    assert_text I18n.t('devise.invitations.invitation_token_invalid')
    expect_fields_to_be_blank
  end
  
  
  private 
  
    def expect_fields_to_be_blank
      assert_empty find_field('Email',    type: 'email').value
      assert_empty find_field('Password', type: 'password', :match => :prefer_exact).value
    end  
       
    def invite_correct_user_and_logout
      fill_in 'Email',    with: 'not@existing.user'
      click_button I18n.t('devise.invitations.new.submit_button')
      assert_equal new_user_invitation_path(:locale=>I18n.locale), current_path
      assert_empty find_field('Email', type: 'email').value
      assert_text I18n.t('devise.invitations.send_instructions', email: 'not@existing.user')
      logout
    end
    
    def invite_incorrect_user_and_logout email, msg
      fill_in 'Email',    with: email
      click_button I18n.t('devise.invitations.new.submit_button')
      assert_equal user_invitation_path(:locale=>I18n.locale), current_path
      assert_selector 'input#user_email+span', text: msg
      logout
    end

    def logout
      click_link I18n.t('shared.labels.logout')
      assert_equal new_user_session_path(:locale=>I18n.locale), current_path
      assert_text I18n.t('shared.labels.registration')
      assert_text I18n.t('devise.sessions.signed_out')
      expect_fields_to_be_blank
    end
end