Given /^the following spoilers:$/ do |spoilers|
  Spoilers.create!(spoilers.hashes)
end

When /^I delete the (\d+)(?:st|nd|rd|th) spoilers$/ do |pos|
  visit spoilers_path
  within("table tr:nth-child(#{pos.to_i+1})") do
    click_link "Destroy"
  end
end

Then /^I should see the following spoilers:$/ do |expected_spoilers_table|
  expected_spoilers_table.diff!(tableish('table tr', 'td,th'))
end

Given /^I have the spoiler tags$/ do |table|
  user = User.where(:login => "dpmcnevin").first
  for spoiler in table.hashes
    user.spoilers.create(spoiler)
  end
end

