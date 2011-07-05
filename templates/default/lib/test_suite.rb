run 'rails generate rspec:install'
run 'rails generate cucumber:install --capybara --rspec'
run 'rails generate pickle --email'

inject_into_file 'config/application.rb', :after => "# Configure the default encoding used in templates for Ruby 1.9.\n" do
<<-RUBY
    config.generators do |g|
      g.test_framework :rspec
    end
RUBY
end

# inject_into_file 'features/support/env.rb', :after => "ENV[\"Rails.env\"] ||= \"test\"\n" do
# <<-RUBY
# $VERBOSE = nil
# RUBY
# end

# gsub_file 'features/support/env.rb', /require 'cucumber\/rails\/capybara_javascript_emulation'/, '#require \'cucumber/rails/capybara_javascript_emulation\''

run 'mkdir spec/factories'

create_file 'features/step_definitions/web_steps_extended.rb' do
<<-'FILE'
When /^I confirm a js popup on the next step$/ do
  page.evaluate_script("window.alert = function(msg) { return true; }")
  page.evaluate_script("window.confirm = function(msg) { return true; }")
end

When /^I perform the following actions:$/ do |table|
  table.hashes.each do |row|
    case row['Action']
    when 'Fill in'
      Given "I fill in \"#{row['Field']}\" with \"#{row['Value']}\""
    when 'Check'
      if row['Value'] =~ /true/
        Given "I check \"#{row['Field']}\""
      else
        Given "I uncheck \"#{row['Field']}\""
      end
    when 'Choose'
      Given "I choose \"#{row['Field']}\""
    end
  end
end
FILE
end

create_file 'features/step_definitions/factory_steps.rb' do
<<-'FILE'
Given /^the following (.+) records?$/ do |factory, table|
  table.hashes.each do |hash|
    Factory(factory, hash)
  end
end
FILE
end
