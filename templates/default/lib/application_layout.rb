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
= javascript_include_tag :application
= yield(:end_scripts)
- if Rails.env == 'production'
  :javascript
    var _gaq = [['_setAccount', 'UA-XXXXX-X'], ['_trackPageview']];
    (function(d, t) {
      var g = d.createElement(t),
        s = d.getElementsByTagName(t)[0];
      g.async = true;
      g.src = ('https:' == location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
      s.parentNode.insertBefore(g, s);
    })(document, 'script');
FILE
end

run 'rm app/views/layouts/application.html.erb'
create_file 'app/views/layouts/application.html.haml' do
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
    %meta{:name => 'description', :content => ''}
    %meta{:name => 'author', :content => ''}
    %meta{:name => 'viewport', :content => 'width=device-width initial-scale=1.0 maximum-scale=1.0'}
    %meta{:name => 'apple-mobile-web-app-capable', :content => 'yes'}
    = csrf_meta_tag
    %link{:rel => "shortcut icon", :href => "/favicon.ico", :type => "image/x-icon"}
    %link{:rel => "apple-touch-icon", :href => "/images/ati.png"}
    /[if lt IE 9]
      %script{:type => "text/javascript", :src  => "/assets/shiv.js"}
    = stylesheet_link_tag :main, :media => 'all'
    = yield(:head)
  %body
    #container
      = render :partial => "shared/header"
      %section#content
        = yield
    = render :partial => "shared/footer"
    = render :partial => "shared/end_scripts"
FILE
end

create_file 'public/maintenance.html' do
<<-FILE
<!DOCTYPE html>
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gte IE 9)|!(IE)]><!-->
<html class='no-js' lang='en'>
  <!--<![endif]-->
  <head>
    <meta content='text/html; charset=utf-8' http-equiv='Content-Type'>
    <meta content='IE=edge,chrome=1' http-equiv='X-UA-Compatible'>
    <title>#{app_name.humanize} is down for maintenance</title>
    <meta content='width=device-width initial-scale=1.0 maximum-scale=1.0' name='viewport'>
    <link href='/favicon.ico' rel='shortcut icon' type='image/x-icon'>
    <!--[if lt IE 9]>
      <script src='/assets/shiv.js' type='text/javascript'></script>
    <![endif]-->
    <Link href="/assets/main.css" media="all" rel="stylesheet" type="text/css" />
  </head>
  <body>
    <div id='container'>
      <section id='content'>
        <h1>#{app_name.humanize} is down for maintenance</h1>
      </section>
    </div>
  </body>
</html>
FILE
end
