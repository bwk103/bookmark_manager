def add_link
  visit '/links'
  click_link 'Add Link'
  fill_in 'title', with: 'Twitter'
  fill_in 'url', with: 'http://www.twitter.com'
  click_button 'Submit'
end

def add_link_with_tag
  visit '/links'
  click_link 'Add Link'
  fill_in 'title', with: 'Twitter'
  fill_in 'url', with: 'http://www.twitter.com'
  fill_in 'tags', with: 'Social Networks'
  click_button 'Submit'
end
