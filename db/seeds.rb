=begin
This file should contain all the record creation needed to seed the database with its default values.
The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
=end

roles = [:admin, :owner, :user]
roles.each do |role|
  Role.new(:name => role.to_s).save!
end

unless Rails.env.production?
  users     = ['admin@test.com', 'a@b.ru', 'b@b.ru', 'c@b.ru']
  password  = '123321123'
  
  users.each.with_index  do |email, index|
    user = User.new(
      :email => email,
      :password => password,
      :password_confirmation => password,
      :account_id => Account.create().id
    )
    user.role_ids = (index == 0) ? [1,2] : [2] 
    user.confirm
    user.save
    
    Subscription.create :email => email, :name => index
    
  end

end