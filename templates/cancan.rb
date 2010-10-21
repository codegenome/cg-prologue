say "Building roles"
generate(:model, "role name:string")
generate(:migration, "UsersHaveAndBelongToManyRoles")
habtm_roles = Dir['db/migrate/*_users_have_and_belong_to_many_roles.rb'].first
inject_into_file habtm_roles, :after => "def self.up\n" do
<<-RUBY
    create_table :roles_users, :id => false do |t|
      t.references :role, :user
    end
RUBY
end

inject_into_file habtm_roles, :after => "def self.down\n" do
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

inject_into_file 'app/models/user.rb', :before => "end\n" do
<<-RUBY

  def role?(role)
    return !!self.roles.find_by_name(role.to_s.camelize)
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
  <<-RUBY
      .form_row
        - for role in Role.find(:all, :order => "name")
          .check_box_item
            = check_box_tag "user[role_ids][]", role.id, @user.roles.include?(role)
            = role.name.humanize
  RUBY
  end

  inject_into_file 'app/controllers/admin/users_controller.rb', :after => "@user = User.new(params[:user])\n" do
  <<-'RUBY'
    @user.role_ids = params[:user][:role_ids] if current_user.role? :admin
  RUBY
  end

  inject_into_file 'app/controllers/admin/users_controller.rb', :before => "if @user.update_attributes(params[:user])\n" do
  <<-'RUBY'
    @user.send(:attributes=, { :role_ids => params[:user][:role_ids] }, false) if current_user.role? :admin
    params[:user].delete(:role_ids)
    
  RUBY
  end

  inject_into_file 'app/controllers/admin/users_controller.rb', :after => "def update\n" do
  <<-'RUBY'
    params[:user][:role_ids] ||= []
  RUBY
  end
end

append_file 'db/seeds.rb' do
<<-FILE
Role.create! :name => 'Admin'.camelize
Role.create! :name => 'Member'.camelize

user1 = User.find_by_email('#{ENV['PROLOGUE_USER_EMAIL']}')
user1.role_ids = [1,2]
user1.save
FILE
end






