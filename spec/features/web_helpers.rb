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
  fill_in 'tags', with: 'social'
  click_button 'Submit'
end

def new_user
  visit '/users/new'
  fill_in 'email', with: 'bob@test.com'
  fill_in 'password', with: 'test'
  fill_in 'password_confirmation', with: 'test'
  click_button 'Signup'
end
