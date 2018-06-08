# Pestulon

Pestulon is a free opensource starting project for Rails 

Abilities:

* Register, invite, oAuth users with devise an reCaptcha

* Has static pages

* Subscriptions

* Administrative panel

* Supports multiple languages

* Contains system tests 

* Supports postgresql

* Twitter Bootstrap 3 based Shield theme https://blacktie.co/shield-one-page-theme/

* Heroku, Docker, Amazon Beanstalk friendly


Requirements: 

* Ruby 2.5.1

* Rails 5.2.0

* Postgres 10.4 for default configuration

* Google Chrome for default testing configuration

First run: 

* Clone this repo 

* At project dir ```bundle install && bin/rails db:setup```

* Run server ```bin/rails``` and go to 127.0.0.1:3000  with your browser

* DO NOT FORGET ABOUT CREATING NEW VALID CREDENTIALS ```bin/rails credentials:help```

Testing

* By default you can run system tests with headless Google Chrome ```bin/rails test:system``` Uncomment ```# driven_by :selenium, using: :chrome, screen_size: [1200, 600]``` at tests/application_system_test_case.rb   if you want to watch system tests running in a Google Chrome window.

* Regular tests are available too with ```bin/rails test```