class Account < ApplicationRecord
  acts_as_paranoid
  before_validation :setup_number, on: :create

  has_many :users, :dependent => :destroy
  # has_many :wallets, :dependent => :destroy
  paginates_per 25

  private

  def setup_number
    begin
      self.number = Random.new.rand(0..999999999)
    rescue ActiveRecord::RecordNotUnique
      retry
      # end
    end while self.class.exists?(number: number)
  end
end
