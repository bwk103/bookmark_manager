  describe 'reset password', type: :feature do

  before(:each) do
    DatabaseCleaner.clean
    new_user
    Capybara.reset!
    allow(SendRecoveryLink).to receive(:call)

  end

  let(:user) { User.first }

  scenario 'users can see a method to retrieve password' do
    visit '/sessions/new'
    expect(page).to have_link 'Reset Password'
  end

  scenario 'users submit email for recovery and get a confirmation message' do
    visit '/sessions/new'
    click_link 'Reset Password'
    expect(page).to have_field 'email'
  end

  scenario 'users are shown a confirmation message' do
    recover_password
    expect(page).to have_content 'Thanks. Please check your inbox for the link'
  end

  scenario 'a password token is set on the user following request' do
    recover_password
    expect { recover_password }.to change { User.first.password_token }
  end

  scenario 'users cannot use the token after one hour has passed' do
    recover_password
    Timecop.travel(60*60*60) do
      visit "/users/reset_password?token=#{user.password_token}"
      expect(page).to have_content 'Your token is invalid'
    end
  end

  scenario 'users can use the token to reset the password within an hour' do
    recover_password
    visit "/users/reset_password?token=#{user.password_token}"
    expect(page).to have_content 'Please enter your new password'
    expect(page).to have_field 'new_password'
    expect(page).to have_field 'new_password_confirmation'
  end

  scenario 'users can use the token to reset the password within an hour' do
    recover_password
    change_password
    expect(page).to have_content 'Login'
  end

  scenario 'the password does not reset if the confirmation does not match' do
    recover_password
    visit "/users/reset_password?token=#{user.password_token}"
    fill_in 'new_password', with: 'newtest'
    fill_in 'new_password_confirmation', with: 'wrong'
    click_button 'Submit'
    expect(page).to have_content('Password does not match the confirmation')
  end

  scenario 'users can sign in with their new passwords' do
    recover_password
    change_password
    fill_in 'email', with: 'bob@test.com'
    fill_in 'password', with: 'newtest'
    click_button 'Sign in'
    expect(page).to have_content "Welcome, bob@test.com"
  end

  scenario 'it resets the token upon a successful password change' do
    recover_password
    change_password
    visit "/users/reset_password?token=#{user.password_token}"
    expect(page).to have_content 'Your token is invalid'
  end

  scenario 'it calls the SendRecoverLink service to send the link' do
    expect(SendRecoveryLink).to receive(:call).with(user)
    recover_password
  end
end
