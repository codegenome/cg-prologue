remove_file 'app/views/admin/dashboard/index.html.haml'
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
- if flash[:alert]
  %div#alert{:class => "flasher"}= flash[:alert]
FILE
end

create_file 'app/views/admin/shared/_footer.html.haml' do
<<-FILE
%footer#main_admin_footer
FILE
end

create_file 'app/views/admin/shared/_end_scripts.html.haml' do
<<-FILE
= include_javascripts :common
FILE
end

create_file 'app/views/layouts/admin.html.haml' do
<<-FILE
!!! 5
-# paulirish.com/2008/conditional-stylesheets-vs-css-hacks-answer-neither/
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gte IE 9)|!(IE)]><!-->
%html.no-js{ :lang => "en" }
  <!--<![endif]-->
  %head
    %meta{'http-equiv' => 'Content-Type', :content => 'text/html; charset=utf-8'}
    %meta{'http-equiv' => 'X-UA-Compatible', :content => 'IE=edge,chrome=1'}
    %title<
      #{app_name.humanize}
      = yield(:title)
    %meta{:name => 'viewport', :content => 'width=device-width initial-scale=1.0 maximum-scale=1.0'}
    %meta{:name => 'apple-mobile-web-app-capable', :content => 'yes'}
    = csrf_meta_tag
    %link{:rel => "shortcut icon", :href => "/favicon.ico", :type => "image/x-icon"}
    /[if lt IE 9]
      %script{:type => "text/javascript", :src  => "/javascripts/shiv.js"}
    = include_stylesheets :admin, :media => 'all'
    = yield(:head)
  %body
    #container
      = render :partial => "admin/shared/header"
      %section#content
        = yield
    = render :partial => "admin/shared/footer"
    = render :partial => "admin/shared/end_scripts"
FILE
end
