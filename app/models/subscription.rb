class Subscription < ApplicationRecord
  acts_as_paranoid
  validates_presence_of :email
  # validates_presence_of :name 
  validates :email, uniqueness: true   
  validates_format_of :email,:with => Devise::email_regexp  
  paginates_per 10
end
