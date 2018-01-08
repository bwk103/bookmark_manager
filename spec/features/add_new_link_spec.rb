  feature 'users can add new links', type: :feature do

  scenario 'users are given option to add new link' do
    visit '/links'
    expect(page).to have_link 'Add Link'
  end

  scenario 'users can add information about a new link' do
    visit '/links'
    click_link 'Add Link'
    expect(page).to have_field 'title'
    expect(page).to have_field 'url'
    expect(page).to have_button 'Submit'
  end

  scenario 'users are redirected to the /links page' do
    add_link
    expect(current_path).to eq '/links'
  end

  scenario 'the new link is added to the collection' do
    add_link
    expect(page).to have_content 'Twitter'
    expect(page).to have_content 'http://www.twitter.com'
  end
end
