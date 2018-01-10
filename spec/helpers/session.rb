
module SessionHelpers

  def new_user
    visit '/users/new'
    fill_in 'email', with: 'bob@test.com'
    fill_in 'password', with: 'test'
    fill_in 'password_confirmation', with: 'test'
    click_button 'Signup'
  end

  def sign_in
    visit '/sessions/new'
    fill_in 'email', with: 'bob@test.com'
    fill_in 'password', with: 'test'
    click_button 'Sign in'
  end

  def recover_password
    visit '/sessions/new'
    click_link 'Reset Password'
    fill_in 'email', with: 'bob@test.com'
    click_button 'Submit'
  end

  def change_password
    visit "/users/reset_password?token=#{user.password_token}"
    fill_in 'new_password', with: 'newtest'
    fill_in 'new_password_confirmation', with: 'newtest'
    click_button 'Submit'
  end
end
