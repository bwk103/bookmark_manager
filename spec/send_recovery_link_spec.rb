require 'send_recovery_link'

describe SendRecoveryLink do
  let(:user) { double :user, email: 'test@test.com', password_token: '12345678' }
  let(:mail_gun_client) { double :mail_gun_client }
  let(:sandbox_domain_name) { ENV['MAILGUN_DOMAIN'] }

  it 'sends a message to mailgun when it is called' do
    params = {
      from: 'bookmarkmanager@mail.com',
      to: user.email,
      subject: 'Password Reset',
      text: "click here to reset your password https://pacific-island-23197.herokuapp.com/users/reset_password?token=#{user.password_token}"
    }
    expect(mail_gun_client).to receive(:send_message).with(sandbox_domain_name, params)
    described_class.call(user, mail_gun_client)
  end

end
