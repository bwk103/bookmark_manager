feature 'users sign out', type: :feature do
  scenario 'users see a link allowing them to sign out' do
    sign_in
    expect(page).to have_button 'Sign out'
  end

  scenario 'users can sign out' do
    sign_in
    click_button 'Sign out'
    expect(current_path).to eq '/links'
    expect(page).to have_content 'Goodbye'
  end
end
