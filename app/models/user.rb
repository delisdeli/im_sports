class User < ActiveRecord::Base
  # attr_accessible :admin, :email, :name, :password_digest, :remember_token
  
  # before_save { self.email = email.downcase }
  # before_create :create_remember_token

  # validates :name,  presence: true, length: { maximum: 50 }
  # VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  # validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
  #                   uniqueness: { case_sensitive: false }
  # has_secure_password 
  # validates :password, length: { minimum: 6 }

  has_and_belongs_to_many :teams
  has_many :invitations
  has_many :notifications
  attr_accessible :name, :email, :password, :password_confirmation, :remember_token, :has_new_message, :notification_counter
  has_secure_password

  after_create { |user| user.notification_counter = 0}
  before_save { |user| user.email = email.downcase }

  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true
  
  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def clear_notifications
    self.notification_counter = 0 if self.notification_counter == nil
    self.notifications.order(created_at: :asc).limit(self.notifications.count-self.notification_counter).each do |note|
      note.destroy
    end
  end

  def read_messages
    self.has_new_message = false
    self.notification_counter = 0
    self.save
  end

  def recent_notifications
    self.notifications.order(created_at: :desc).limit(self.notification_counter)
  end

  def iterate_notification_counter
    self.has_new_message = true
    if (self.notification_counter == nil)
      self.notification_counter = 1
    else
      self.notification_counter += 1
    end
    self.save
  end

  private

    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end

end
