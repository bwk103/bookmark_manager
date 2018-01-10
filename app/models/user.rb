require 'bcrypt'
require 'securerandom'

class User

  include DataMapper::Resource

  property :id, Serial
  property :email, String, required: true
  property :password_digest, Text
  property :password_token, String, length: 60
  property :password_token_time, Time

  attr_reader :password
  attr_accessor :password_confirmation

  validates_presence_of :email
  validates_format_of :email, :as => :email_address
  validates_uniqueness_of :email
  validates_confirmation_of :password

  def self.authenticate(email, password)
    user = first(email: email)
    if user && BCrypt::Password.new(user.password_digest) == password
      user
    else
      nil
    end
  end

  def self.find_by_valid_token(token)
    @user = first(password_token: token)
      if @user && Time.now < @user.password_token_time + (60*60)
        @user
      else
        nil
      end
  end

  def password=(password)
    @password=password
    self.password_digest = BCrypt::Password.create(password)
  end

  def generate_token
    self.password_token = SecureRandom.hex
    self.password_token_time = Time.now
    self.save
  end

end
