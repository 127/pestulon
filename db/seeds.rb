=begin
This file should contain all the record creation needed to seed the database with its default values.
The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
=end

roles = [:admin, :owner, :user]
roles.each do |role|
  Role.new(:name => role.to_s).save!
end

unless Rails.env.production?
  users     = ['mamyashev.marat@gmail.com', 'a@b.ru', 'b@b.ru', 'c@b.ru']
  accounts  = [123456789, 987654321]
  password  = '123321123'
  
  users.each do |email|
    account = Account.where('number' => accounts.sample).first_or_create
    user = User.new(
      :email => email,
      :password => password,
      :password_confirmation => password,
      :account_id => account.id
    )
    user.confirm
    user.save
  end

end