feature 'Users can sign up', type: :feature do

  scenario 'users can enter details in a form' do
    visit '/users/new'
    expect(page).to have_field 'email'
    expect(page).to have_field 'password'
    expect(page).to have_button 'Signup'
  end

  scenario 'users are redirected to the /links page' do
    new_user
    expect(current_path).to eq '/links'
  end

  scenario 'users are welcomed on their links page' do
    new_user
    expect(page).to have_content 'Welcome to Bookmark Manager, bob@test.com'
  end

  scenario 'users are added to the database' do
    expect { new_user }.to change { User.count }.by(1)
  end
end
