create_file 'app/views/admin/dashboard/index.html.haml' do
<<-FILE
%h1 #{app_name.humanize} Admin
FILE
end

run 'mkdir app/views/admin/shared'

create_file 'app/views/admin/shared/_header.html.haml' do
<<-FILE
%header#main_admin_header
  %h1= link_to '#{app_name.humanize}', root_path
= render 'admin/shared/messages'
%nav#main_admin_nav
  %ul
    %li= link_to 'Home', root_path    
  %ul#user_admin_nav
    = render 'devise/menu/login_items'
FILE
end

create_file 'app/views/admin/shared/_messages.html.haml' do
<<-FILE
- if flash[:notice]
  %div#messenger{:class => "flasher"}= flash[:notice]
- if flash[:error]
  %div#error{:class => "flasher"}= flash[:error]
FILE
end

create_file 'app/views/admin/shared/_footer.html.haml' do
<<-FILE
%footer#main_admin_footer
FILE
end

create_file 'app/views/admin/shared/_end_scripts.html.haml' do
<<-FILE
= javascript_include_tag :defaults
FILE
end

create_file 'app/views/layouts/admin.html.haml' do
<<-FILE
!!! 5
%html
  %head
    %meta{'http-equiv' => 'Content-Type', :content => 'text/html; charset=utf-8'}
    %meta{'http-equiv' => 'X-UA-Compatible', :content => 'IE=edge,chrome=1'}
    %title 
      #{app_name.humanize}
      = yield(:title)
    %meta{:name => 'viewport', :content => 'width=device-width; initial-scale=1.0'}
    = csrf_meta_tag
    %link{:rel => "shortcut icon", :href => "/images/favicon.ico", :type => "image/x-icon"}
    /[if lt IE 9]
      %script{:type => "text/javascript", :src  => "/javascripts/shiv.js"}
    = stylesheet_link_tag "admin"
    = yield(:head)
    /[if IE 7]
      = stylesheet_link_tag 'ie7', :media => 'all'
    /[if IE 8]
      = stylesheet_link_tag 'ie8', :media => 'all'
  %body
    #container
      = render :partial => "admin/shared/header"
      %section#content
        = yield
      #pusher
    = render :partial => "admin/shared/footer"
    = render :partial => "admin/shared/end_scripts"
FILE
end