feature 'users can see links', type: :feature do

  scenario 'it shows the links stored in the bookmark manager' do
    Link.create(url: 'http://www.bbc.co.uk/sport', title: 'BBC Sport')
    visit '/links'
    expect(page).to have_link 'BBC Sport'
  end
end
