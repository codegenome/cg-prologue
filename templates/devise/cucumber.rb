create_file 'features/authentication.feature' do
<<-'FILE'
Feature: User admin authentication
  As an administrator
  I want to manage the application
  So that I can have full control over the site

  Scenario: Login as an admin
    Given a logged in admin user
    When I am on the admin
    Then I should see "Admin"
FILE
end

create_file 'spec/factories/user.rb' do
<<-'FILE'
Factory.define :user do |u| 
  u.sequence(:name) { |n| "Quick #{n}" }
  u.sequence(:email) { |n| "info.#{n}@quickleft.com" }
  u.password "password" 
  u.confirmed_at Time.new.to_s
  u.confirmation_sent_at Time.new.to_s
  u.password_confirmation { |u| u.password } 
end 

Factory.define :admin, :parent => :user do |admin| 
  admin.email "quickleft@quickleft.com"
  admin.password "password" 
  admin.roles { [ Factory(:role, :name => 'admin') ] } 
end 

Factory.define :member, :parent => :user do |member|
  member.email "member@quickleft.com"
  member.password "password"
  member.roles { [ Factory(:role, :name => 'member') ] } 
end

Factory.define :role do |role| 
  role.sequence(:name) { |n| "Quick #{n}".camelize }
end
FILE
end

create_file 'features/step_definitions/devise_steps.rb' do
<<-'FILE'
When /^I log in as "([^\"]*)" with password "([^\"]*)"$/ do |email, password|
  visit(new_user_session_path)
  fill_in("user[email]", :with => email)
  fill_in("user[password]", :with => password)
  click_button("Sign in")
end

Given /^a logged in admin user$/ do
  Factory.create(:admin)
  visit(new_user_session_path)
  fill_in("user[email]", :with => "quickleft@quickleft.com")
  fill_in("user[password]", :with => "password")
  click_button("Sign in")
end

Given /^a logged in member user$/ do
  Factory.create(:member)
  visit(new_user_session_path)
  fill_in("user[email]", :with => "member@quickleft.com")
  fill_in("user[password]", :with => "password")
  click_button("Sign in")
end

When /^I log out$/ do
  visit(destroy_user_session_path)
end

Given /^a user "([^\"]*)"$/ do |email|
  Factory.create(:user, :email => email)
end
FILE
end

inject_into_file 'features/support/paths.rb', :after => "case page_name\n" do
<<-'FILE'
      
      when /the admin/
        '/admin'

      when /logout/
        '/users/sign_out'

      when /login/
        '/users/sign_in'
FILE
end