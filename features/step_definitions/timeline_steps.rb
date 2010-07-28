Given /^the following timelines:$/ do |timelines|
  Timeline.create!(timelines.hashes)
end

When /^I delete the (\d+)(?:st|nd|rd|th) timeline$/ do |pos|
  visit timelines_path
  within("table tr:nth-child(#{pos.to_i+1})") do
    click_link "Destroy"
  end
end

Then /^I should see the following timelines:$/ do |expected_timelines_table|
  expected_timelines_table.diff!(tableish('table tr', 'td,th'))
end
