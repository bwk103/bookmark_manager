feature 'password validation', type: :feature do

  scenario 'users are asked to confirm their password' do
    visit '/users/new'
    fill_in 'email', with: 'bill@test.com'
    fill_in 'password', with: 'test'
    fill_in 'password_confirmation', with: 'tast'
    expect { click_button 'Signup' }.to_not change { User.count }
    expect(current_path).to eq '/users/new'
    message = 'Password and confirmation password do not match'
    expect(page).to have_content message
  end

  scenario "users can't signup with a blank email address" do
    visit '/users/new'
    fill_in 'password', with: 'test'
    fill_in 'password_confirmation', with: 'test'
    click_button 'Signup'
    expect(current_path).to eq '/users/new'
  end

  scenario 'users cannot sign up without a valid email address' do
    visit '/users/new'
    fill_in 'email', with: 'Notanemail'
    fill_in 'password', with: 'test'
    fill_in 'password_confirmation', with: 'test'
    click_button 'Signup'
    expect(current_path).to eq '/users/new'
  end
end
