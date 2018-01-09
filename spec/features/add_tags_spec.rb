feature 'add tags', type: :feature do

  scenario 'users can add individual tags to links' do
    visit '/links'
    click_link 'Add Link'
    expect(page).to have_field 'tags'
  end

  scenario 'users can add multiple tags to links' do
    visit '/links/new'
    fill_in 'title', with: 'BDO Darts'
    fill_in 'url', with: 'www.bdodarts.co.uk'
    fill_in 'tags', with: 'sport darts entertainment'
    click_button 'Submit'
    link = Link.last
    expect(link.tags.map(&:name)).to include('sport', 'entertainment', 'darts')
  end

  scenario 'tags are saved' do
    add_link_with_tag
    expect(page).to have_content 'social'
  end

end
