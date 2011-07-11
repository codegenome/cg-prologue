generate(:controller, "admin/users index new create edit update destroy")

run 'rm app/views/admin/users/destroy.html.haml'

inject_into_file 'config/routes.rb', :after => "devise_for :users\n" do
<<-'FILE'
  namespace "admin" do
    resources :users
  end
FILE
end

inject_into_file 'app/controllers/admin/users_controller.rb', :after => "def index\n" do
<<-'FILE'
    @search = User.search params[:search]
    @users = @search.paginate(:page => params[:page],
                              :per_page => 50)
FILE
end

inject_into_file 'app/controllers/admin/users_controller.rb', :after => "def new\n" do
<<-'FILE'
    @user = User.new
FILE
end

inject_into_file 'app/controllers/admin/users_controller.rb', :after => "def create\n" do
<<-'FILE'
    @user = User.new
    # attr_accessor logic here
    @user.attributes = params[:user]
    if @user.save
      flash[:notice] = "User created successfully."
      redirect_to admin_users_url
    else
      render :action => 'new'
    end
FILE
end

inject_into_file 'app/controllers/admin/users_controller.rb', :after => "def update\n" do
<<-'FILE'
    params[:user].delete(:password) if params[:user][:password].blank?
    params[:user].delete(:password_confirmation) if params[:user][:password].blank? and params[:user][:password_confirmation].blank?
    # attr_accessor logic here
    if @user.update_attributes(params[:user])
      flash[:notice] = "Successfully updated #{@user.name}."
      redirect_to admin_users_url
    else
      render :action => 'edit'
    end
FILE
end

inject_into_file 'app/controllers/admin/users_controller.rb', :after => "def destroy\n" do
<<-'FILE'
    @user.destroy
    flash[:notice] = "User #{@user.name} has been deleted."
    redirect_to admin_users_url
FILE
end

gsub_file 'app/controllers/admin/users_controller.rb', /ApplicationController/, 'Admin::BaseController'

inject_into_file 'app/controllers/admin/users_controller.rb', :after => "class Admin::UsersController < Admin::BaseController\n" do
<<-'FILE'
  before_filter :find_user, :only => [:edit, :update, :destroy]

  def find_user
    @user = User.find(params[:id])
  end

FILE
end

create_file 'app/views/admin/users/_form.html.haml' do
<<-'FILE'
= semantic_form_for([:admin, @user]) do |f|
  = f.inputs do
    = f.input :name
    = f.input :email
    = f.input :password
    = f.input :password_confirmation
  = f.buttons
FILE
end

remove_file 'app/views/admin/users/edit.html.haml'
create_file 'app/views/admin/users/edit.html.haml' do
<<-'FILE'
= render :partial => "form"

- content_for :title_bar do
  = title_bar('Edit User') do |breadbrumb, actions|
    - breadbrumb['Admin'] = admin_path
    - breadbrumb['Users'] = admin_users_path
FILE
end

remove_file 'app/views/admin/users/new.html.haml'
create_file 'app/views/admin/users/new.html.haml' do
<<-'FILE'
= render :partial => "form"

- content_for :title_bar do
  = title_bar('New User') do |breadbrumb, actions|
    - breadbrumb['Admin'] = admin_path
    - breadbrumb['Users'] = admin_users_path
FILE
end

remove_file 'app/views/admin/users/index.html.haml'
create_file 'app/views/admin/users/index.html.haml' do
<<-FILE
- if !@users.blank?
  %table.index_table
    %thead
      %tr
        %th= sort_link @search, :name
        %th= sort_link @search, :email
        %th
    %tbody
      - @users.each do |user|
        %tr
          %td= link_to user.name, edit_admin_user_path(user)
          %td= user.email
          %td
            = link_to "Edit", edit_admin_user_path(user)
            - if user.id != current_user.id
              |
              = link_to "Delete", admin_user_path(user), :confirm => 'Are you sure?', :method => :delete
  = will_paginate @users
- else
  %p No users

- content_for :title_bar do
  = title_bar('Users') do |breadbrumb, actions|
    - breadbrumb['Admin'] = admin_path
    - actions['New user'] = new_admin_user_path

- content_for :sidebar do
  = render 'index_sidebar'
FILE
end

create_file 'app/views/admin/users/_index_sidebar.html.haml' do
<<-FILE
%section.panel.sidebar_section
  %header
    %h3 Filters
  .panel_contents
    = form_for @search, :url => admin_users_path, :html => { :class => :filter_form } do |f|
      .filter_form_field.filter_string
        %label Name
        = f.text_field :name_contains
      .filter_form_field.filter_string
        %label Email
        = f.text_field :email_contains
      .filter_form_field.filter_check_boxes
        %label Roles
        .check_boxes_wrapper
          - f.collection_checks :roles_id_in, Role.order(:name), :id, :name do |check|
            = check.box
            = check.label
            %br
      .buttons
        = f.submit 'Filter'
        = link_to 'Clear Filters', '#', :class => :clear_filters_btn
FILE
end
