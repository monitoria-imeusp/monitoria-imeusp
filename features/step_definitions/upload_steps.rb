
When(/^I upload the "(.*?)" file to "(.*?)"$/) do |file, chooser|
  attach_file(chooser, Rails.root.join('features', 'upload_files', file))
end
