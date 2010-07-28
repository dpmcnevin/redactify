Given /^I am signed in$/ do  
  visit login_path
  visit oauth_callback_path
end  

When /^Twitter authorizes me$/ do
  visit oauth_callback_path
end

Given /^the following logins:$/ do |logins|
  Login.create!(logins.hashes)
end

When /^I delete the (\d+)(?:st|nd|rd|th) login$/ do |pos|
  visit logins_path
  within("table tr:nth-child(#{pos.to_i+1})") do
    click_link "Destroy"
  end
end

Then /^I should see the following logins:$/ do |expected_logins_table|
  expected_logins_table.diff!(tableish('table tr', 'td,th'))
end
