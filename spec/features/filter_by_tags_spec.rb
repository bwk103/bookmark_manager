feature 'users can filter by tags', type: :feature do

  before(:each) do
    Link.create(url: 'www.google.com', title: 'Google', tags: [Tag.first_or_create(name: 'search')])
    Link.create(url: 'www.bbc.com', title: 'BBC', tags: [Tag.first_or_create(name: 'media')])
    Link.create(url: 'www.sky.com', title: 'Sky', tags: [Tag.first_or_create(name: 'media')])
    Link.create(url: 'www.bubble.com', title: 'Bubble Page', tags: [Tag.first_or_create(name: 'bubbles')])
  end

  scenario 'users can find selected tags' do
    visit '/tags/bubbles'
    expect(page).not_to have_content 'BBC'
    expect(page).not_to have_content 'Google'
    expect(page).not_to have_content 'Sky'
    expect(page).to have_content 'Bubble Page'
  end
end
