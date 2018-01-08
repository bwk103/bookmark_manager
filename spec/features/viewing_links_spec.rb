feature 'users can see links', type: :feature do

  scenario 'it shows the links stored in the bookmark manager' do
    Link.create(url: 'http://www.bbc.co.uk/sport', title: 'BBC Sport')
    visit '/'
    expect(page).to have_content 'www.bbc.co.uk/sport'
  end
end
