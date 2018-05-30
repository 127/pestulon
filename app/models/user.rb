class User < ApplicationRecord
  acts_as_paranoid
  before_validation :setup_role,    on: :create
  before_validation :setup_account, on: :create
  
  TEMP_EMAIL_PREFIX = 'change@me'
  TEMP_EMAIL_REGEX = /\Achange@me/
 
  belongs_to :account
  has_and_belongs_to_many :roles
  has_many :identities, :dependent => :destroy
  # has_many :wallets

  validates_format_of :email, :without => TEMP_EMAIL_REGEX, on: :update

  paginates_per 10

  devise :invitable, :database_authenticatable, :registerable, :confirmable, 
         :lockable, :recoverable, :rememberable, :trackable, :validatable, 
         :omniauthable, :omniauth_providers => [:facebook, :twitter]
  # before_invitation_created :setup_role
  # before_invitation_created :setup_account
  #:facebook, :twitter, :linkedin]

  def role? role
     return !!self.roles.find_by_name(role.to_s)
  end

  def self.find_for_oauth(auth, signed_in_resource = nil)
    # Получить identity пользователя, если он уже существует
    identity = Identity.find_for_oauth(auth)

    # Если signed_in_resource предоставлен оно всегда переписывает существующего пользователя
    # что бы identity не была закрыта случайно созданным аккаунтом.
    # Заметьте, что это может оставить зомби-аккаунты (без прикрепленной identity)
    # которые позже могут быть удалены
    user = signed_in_resource ? signed_in_resource : identity.user

    # Создать пользователя, если нужно
    if user.nil?

      # Получить email пользователя, если его предоставляет провайдер
      # Если email не был предоставлен мы даем пользователю временный и просим
      # пользователя установить и подтвердить новый в следующим шаге через UsersController.finish_signup
      # email_is_verified = auth.info.email && (auth.info.verified || auth.info.verified_email)
      # email = auth.info.email if email_is_verified
      email = auth.info.email if auth.info.email
      user = User.where(:email => email).first if email

      # Создать пользователя, если это новая запись
      if user.nil?
        user = User.new(
          name: auth.extra.raw_info.name,
          email: email ? email : "#{TEMP_EMAIL_PREFIX}-#{auth.uid}-#{auth.provider}.com",
          password: Devise.friendly_token[0,20]
        )
        user.skip_confirmation!
        user.save!
      end
    end

    # Связать identity с пользователем, если необходимо
    if identity.user != user
      identity.user = user
      identity.save!
    end
    user
  end

  def email_verified?
    self.email && self.email !~ TEMP_EMAIL_REGEX
  end
  
  #Protected methods do not invoke in devise_invitable
  protected
  
    def setup_role
       self.role_ids = [3] if self.invited_by_id != nil && self.role_ids.empty?
       self.role_ids = [2] if self.role_ids.empty?
    end

    # Default role is "Registered"
    def setup_account
      self.account = self.invited_by.account if self.invited_by_id != nil && self.account_id == nil
      self.account = Account.create if self.account_id == nil
    end
    
end
