
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
end
