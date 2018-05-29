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
    fill_in 'Email',    with: 'a@b.ru'
    fill_in 'Password', with: 123321123
    click_button I18n.t('shared.links.login')
    assert_text I18n.t('shared.labels.logout')
    
    click_on I18n.t('shared.labels.invite')
    assert_equal new_user_invitation_path(:locale=>I18n.locale), current_path
    assert_empty find_field('Email', type: 'email').value
    
    fill_in 'Email',    with: 'b@b.ru'
    click_on I18n.t('devise.invitations.new.submit_button')
    
  end
  
  test 'invite self' do
  end
  
  test 'invite existing user' do
    #message has already been taken
  end
  
  
  test 'invite user with invalid email' do
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

end