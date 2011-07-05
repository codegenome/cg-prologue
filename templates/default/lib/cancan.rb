say "Building roles"
generate(:model, "role name:string")
generate(:migration, "UsersHaveAndBelongToManyRoles")
habtm_roles = Dir['db/migrate/*_users_have_and_belong_to_many_roles.rb'].first
inject_into_file habtm_roles, :after => "def up\n" do
<<-RUBY
    create_table :roles_users, :id => false do |t|
      t.references :role, :user
    end
RUBY
end

inject_into_file habtm_roles, :after => "def down\n" do
<<-RUBY
    drop_table :roles_users
RUBY
end

inject_into_file 'app/models/user.rb', :after => "class User < ActiveRecord::Base\n" do
<<-RUBY
  has_and_belongs_to_many :roles
RUBY
end

inject_into_file 'app/models/role.rb', :after => "class Role < ActiveRecord::Base\n" do
<<-RUBY
  has_and_belongs_to_many :users

  def self.sanitize role
    role.to_s.humanize.split(' ').each{ |word| word.capitalize! }.join(' ')
  end
RUBY
end

create_file 'app/models/ability.rb' do
<<-RUBY
class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user

    if user.role? :admin
      can :manage, :all
    # elsif user.role? :writter
    #   can :manage, [Post, Asset]
    # elsif user.role? :memeber
    #   can :read, [MemberPost, Asset]
    #   # manage posts, assets user owns
    #   can :manage, Post do |p|
    #     p.try(:owner) == user
    #   end
    #   can :manage, Asset do |a|
    #     a.try(:owner) == user
    #   end
    end
  end
end
RUBY
end

inject_into_file 'app/models/user.rb', :before => "  def destroy\n" do
<<-RUBY

  def role?(role)
    return !!self.roles.find_by_name(Role.sanitize role)
  end

RUBY
end

inject_into_file 'app/controllers/application_controller.rb', :before => "end\n" do
<<-RUBY

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Access Denied"
    redirect_to root_url
  end
RUBY
end

if ENV['PROLOGUE_ADMIN']
  inject_into_file 'app/views/admin/users/_form.html.haml', :after => "= f.password_field :password_confirmation\n" do
  <<-'RUBY'
    .form_row
      - Role.find(:all, :order => "name").each do |role|
        .check_box_item
          = check_box_tag "user[role_ids][]", role.id, @user.roles.include?(role), :id => "user_role_#{role.id}"
          %label{:for => "user_role_#{role.id}"}= role.name.humanize
      = hidden_field_tag "user[role_ids][]", ""
  RUBY
  end

  gsub_file 'app/controllers/admin/users_controller.rb', /# attr_accessor logic here/, '@user.accessible = [:role_ids] if current_user.role? :admin'
end

append_file 'db/seeds.rb' do
<<-FILE
Role.create! :name => 'Admin'
Role.create! :name => 'Member'

user1 = User.find_by_email('#{ENV['PROLOGUE_USER_EMAIL']}')
user1.role_ids = [1, 2]
user1.save
FILE
end






