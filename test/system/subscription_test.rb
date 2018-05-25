require 'application_system_test_case'

class UsersTest < ApplicationSystemTestCase
  
  # tests from root_path
  test 'creating a subscription from ROOT' do
    normal_flow
  end

  test 'creating a subscription with empty email and name from ROOT' do
    empty_fields
  end

  test 'creating a subscription with incorrect email from ROOT' do
   incorrect_email
  end

  test 'creating a subscription with existing email from ROOT' do
    existing_email
  end

  # Tests from new_subscription_path(:locale=>I18n.locale)
  test 'creating a subscription from NEW view' do
    normal_flow new_subscription_path(:locale=>I18n.locale)
  end

  test 'creating a subscription with empty email and name from NEW view' do
    empty_fields new_subscription_path(:locale=>I18n.locale)
  end

  test 'creating a subscription with incorrect email from NEW view' do
   incorrect_email new_subscription_path(:locale=>I18n.locale)
  end

  test 'creating a subscription with existing email from NEW view' do
    existing_email new_subscription_path(:locale=>I18n.locale)
  end
  
  private 
  
    def visit_path_and_check_if_empty path
      visit path
      assert_empty find_field('Email', type: 'email').value
      assert_empty find_field('Name', type: 'text').value
    end
    
    def correct_data_fill_in
      fill_in 'Email', with: 'tester@example.tld'
      fill_in 'Name', with: 'tester@example.tld'
      click_button 'Create subscription'
      assert_selector "h1", text: "You've subscribed!" 
    end
    
    # tests 
    def normal_flow path=root_path
      visit_path_and_check_if_empty path
      correct_data_fill_in
    end
    
    def empty_fields path=root_path
      visit_path_and_check_if_empty path
      click_button 'Create subscription'
      assert_equal subscriptions_path(:locale=>I18n.locale), current_path
      assert_selector "input#subscription_email+span", text: "can't be blank"
      # enable validator in subscriptions model to use thos assert
      # assert_selector "input#subscription_name+span", text: "can't be blank"
      correct_data_fill_in
    end
    
    def incorrect_email path=root_path
      visit_path_and_check_if_empty path
      fill_in 'Email', with: 'invalid-email-for-testing'
      fill_in 'Name', with: 'Somename'
      click_button 'Create subscription'
      assert_selector "input#subscription_email+span", text: "is invalid"
      correct_data_fill_in
    end
    
    def existing_email path=root_path
      visit_path_and_check_if_empty path
      fill_in 'Email', with: 'a@b.ru'
      click_button 'Create subscription'
      assert_equal subscriptions_path(:locale=>I18n.locale), current_path
      assert_selector "input#subscription_email+span", text: 'has already been taken'
      correct_data_fill_in
    end
  
end