feature 'sign in', type: :feature do

  scenario '/links has link to sign in' do
    visit '/links'
    expect(page).to have_content 'Sign in'
  end

  scenario '/sessions/new has form to enter credentials' do
    visit '/sessions/new'
    expect(page).to have_field 'email'
    expect(page).to have_field 'password'
    expect(page).to have_button 'Sign in'
  end

  scenario 'users can sign in' do
    visit '/sessions/new'
    fill_in 'email', with: 'bob@test.com'
    fill_in 'password', with: 'test'
    click_button 'Sign in'
    expect(current_path).to eq '/links'
    expect(page).to have_content 'Welcome, bob@test.com'
  end
end
