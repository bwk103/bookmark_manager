feature 'password validation', type: :feature do

  scenario 'users are asked to confirm their password' do
    visit '/users/new'
    fill_in 'email', with: 'bill@test.com'
    fill_in 'password', with: 'test'
    fill_in 'password_confirmation', with: 'tast'
    expect { click_button 'Signup' }.to_not change { User.count }
  end
end
