Given /^I am signed in$/ do  
  visit login_path
  visit oauth_callback_path
end  

When /^Twitter authorizes me$/ do
  visit oauth_callback_path
end

Then /^I debug$/ do
  debugger
end