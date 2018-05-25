require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  # select headless or visual tests to use
  # driven_by :selenium, using: :headless_chrome
  driven_by :selenium, using: :chrome, screen_size: [1200, 600]
  
  # needed because while visiting links in mail session fails switching to another port
  Capybara.server_port = 3002
end
