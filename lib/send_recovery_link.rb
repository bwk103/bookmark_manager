require 'mailgun'

class SendRecoveryLink

  def initialize(mailer: nil)
    @mailer = mailer || Mailgun::Client.new(ENV['MAILGUN_KEY'])
  end

  def self.call(user, mailer=nil)
    new(mailer: mailer).call(user)
  end

  def call(user)
    mailer.send_message(ENV['MAILGUN_DOMAIN'], {from: 'bookmarkmanager@mail.com',
      to: user.email,
      subject: 'Password Reset',
      text: "click here to reset your password https://pacific-island-23197.herokuapp.com/users/reset_password?token=#{user.password_token}"})
  end

  private

  attr_reader :mailer
end
