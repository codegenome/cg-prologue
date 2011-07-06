
create_file 'spec/factories/user.rb' do
<<-'FILE'
Factory.define :user do |u|
  u.sequence(:name) { |n| "Quick #{n}" }
  u.sequence(:email) { |n| "user.#{n}@quickleft.com" }
  u.password "password"
  u.confirmed_at Time.new.to_s
  u.confirmation_sent_at Time.new.to_s
  u.password_confirmation { |u| u.password }
end

Factory.define :admin, :parent => :user do |admin|
  admin.email "admin@quickleft.com"
  admin.password "password"
  admin.roles { [ Factory(:role, :name => 'Admin') ] }
end

Factory.define :member, :parent => :user do |member|
  member.email "member@quickleft.com"
  member.password "password"
  member.roles { [ Factory(:role, :name => 'Member') ] }
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

Given /^a logged in (\w+)$/ do |usertype|
  Factory.create(usertype.to_sym)
  visit(new_user_session_path)
  fill_in("user[email]", :with => "#{usertype}@quickleft.com")
  fill_in("user[password]", :with => "password")
  click_button("Sign in")
end

When /^I log out$/ do
  visit(destroy_user_session_path)
end

Given /^an? (\w+) "([^\"]*)"$/ do |usertype, email|
  Factory.create(usertype.to_sym, :email => email)
end
FILE
end

inject_into_file 'features/support/paths.rb', :after => "case page_name\n" do
<<-'FILE'

      when /logout/
        '/users/sign_out'

      when /login/
        '/users/sign_in'
FILE
end

create_file 'features/forgot_password.feature' do
<<-'FILE'
Feature: Forgot password
  As an user
  I want to secure way to reset my password
  So that I can still login if I forget it

  Scenario: Follow forget your password link
    Given the following user records
    | email                |
    | forgot@quickleft.com |
    When I am on the login page
    And I follow "Forgot your password?"
    And I fill in "Email" with "forgot@quickleft.com"
    And I press "Send me reset password instructions"
    Then I should see "You will receive an email with instructions about how to reset your password in a few minutes."
    And 1 emails should be delivered to forgot@quickleft.com
    When I click the first link in the email
    And I fill in "New password" with "myNewP@ssword"
    And I fill in "Confirm new password" with "myNewP@ssword"
    And I press "Change my password"
    Then I should see "Your password was changed successfully. You are now signed in."
FILE
end

create_file 'features/resend_verification_email.feature' do
<<-'FILE'
Feature: Resend Verification
  As an user
  I want to resend my verification email
  So that I can activate my account if I lost the original email

  Scenario: Follow resend verification email
    Given the following user records
    | email                | confirmed_at |
    | resend@quickleft.com | nil          |
    When I am on the login page
    And I follow "Didn't receive confirmation instructions?"
    And I fill in "Email" with "resend@quickleft.com"
    And I press "Resend confirmation instructions"
    Then I should see "You will receive an email with instructions about how to confirm your account in a few minutes."
    And 2 emails should be delivered to resend@quickleft.com
    When I click the first link in the email
    Then I should see "Your account was successfully confirmed. You are now signed in."
FILE
end
