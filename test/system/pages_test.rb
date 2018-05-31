require 'application_system_test_case'

class PagesTest < ApplicationSystemTestCase
  test 'test root_path page with NO locale'  do
    visit root_path
    assert_selector 'h1 span.icon-shield'
  end
  
  test 'test root_path with locales' do
    visit root_path :locale=>I18n.locale
    assert_selector 'h1 span.icon-shield'
  end
  
  test 'test innner paths with NO locales' do
    visit pages_path :page=>'contacts'
    assert_selector 'h1', text: 'Contacts'
  end 
  
  test 'test innner paths with locales' do
    visit pages_path :page=>'contacts', :locale=>I18n.locale
    assert_selector 'h1', text: 'Contacts'
  end 
end
