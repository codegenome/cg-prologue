run 'mkdir app/views/shared'

create_file 'app/views/shared/_header.html.haml' do
<<-FILE
%header#main_header
  %h1= link_to '#{app_name.humanize}', root_path
= render 'shared/messages'
%nav#main_nav
  %ul
    %li= link_to 'Home', root_path
FILE
end

create_file 'app/views/shared/_messages.html.haml' do
<<-FILE
- if flash[:notice]
  %div#messenger{:class => "flasher"}= flash[:notice]
- if flash[:error]
  %div#error{:class => "flasher"}= flash[:error]
- if flash[:alert]
  %div#alert{:class => "flasher"}= flash[:alert]
FILE
end

create_file 'app/views/shared/_footer.html.haml' do
<<-FILE
%footer#main_footer
FILE
end

create_file 'app/views/shared/_end_scripts.html.haml' do
<<-FILE
= include_javascripts :common
= yield(:end_scripts)
FILE
end

run 'rm app/views/layouts/application.html.erb'
create_file 'app/views/layouts/application.html.haml' do
<<-FILE
!!! 5
%html
  %head
    %meta{'http-equiv' => 'Content-Type', :content => 'text/html; charset=utf-8'}
    %meta{'http-equiv' => 'X-UA-Compatible', :content => 'IE=edge,chrome=1'}
    %title 
      #{app_name.humanize}
      = yield(:title)
    %meta{:name => 'description', :content => ''}
    %meta{:name => 'author', :content => ''}
    %meta{:name => 'viewport', :content => 'width=device-width initial-scale=1.0 maximum-scale=1.0'}
    %meta{:name => 'apple-mobile-web-app-capable', :content => 'yes'}
    = csrf_meta_tag
    %link{:rel => "shortcut icon", :href => "/images/favicon.ico", :type => "image/x-icon"}
    %link{:rel => "apple-touch-icon", :href => "/images/ati.png"}
    /[if lt IE 9]
      %script{:type => "text/javascript", :src  => "/javascripts/shiv.js"}
    = include_stylesheets :main, :media => 'all'
    = yield(:head)
    /[if IE 7]
      = stylesheet_link_tag 'ie7', :media => 'all'
    /[if IE 8]
      = stylesheet_link_tag 'ie8', :media => 'all'
  %body
    #container
      = render :partial => "shared/header"
      %section#content
        = yield
      #pusher
    = render :partial => "shared/footer"
    = render :partial => "shared/end_scripts"
FILE
end
