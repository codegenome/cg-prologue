run 'rails generate rspec:install'
run 'rails generate cucumber:install --capybara --rspec'
inject_into_file 'config/application.rb', :after => "# Configure the default encoding used in templates for Ruby 1.9.\n" do 
<<-RUBY
    config.generators do |g|
      g.test_framework :rspec
    end
RUBY
end

run 'mkdir spec/factories'