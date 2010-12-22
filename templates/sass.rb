run 'mkdir public/stylesheets/sass'

create_file 'public/stylesheets/sass/main.scss' do
<<-FILE
@import "common";
@mixin layout_base {
  @include reset;
  @include container;
  @include user_nav;
  @include main_nav;
  //uncomment for a handy layout guide
  @include layout_guide;
}

@mixin container($container_size: 950px) {
  #container {
    width: $container_size;
    clear:both;
    padding: 0 20px;
    min-height: 100%;
    height: auto !important;
    height: 100%;
    margin: 0 auto -80px;
  }
  #main_header {
    width: $container_size;
    height: 60px;
    @include clear_left;
    h1 {
      float: left;
      padding: 20px 0 0 0;
      font-size: 24px;
      font-weight: bold;
    }
  }
  #content {
    width: $container_size;
    @include clear_left;
    padding: 10px 0 20px 0;
  }
  #main_footer, #pusher {
    height: 80px;
    clear:both;
  }
}

@mixin user_nav {
  #user_nav {
    float: right;
    padding: 20px 0 0 0;
  }
}

@mixin main_nav {
  #main_nav {
    width: 950px;
    @include clear_left;
    padding: 10px 0;
    ul {
      @include clear_left;
      li {
        float: left;
        padding: 0 15px 0 0;
      }
    }
  }
}

@mixin layout_guide {
  #container { background-color: #e8e6e6; }
  #main_header { background-color: #f7dddd; }
  #main_nav { background-color: #f4ddf7; }
  #content { background-color: #f2f7dd; }
  #main_footer .inner { background-color: #ddf7e7; }
}

@include layout_base;
FILE
end

create_file 'public/stylesheets/sass/common.scss' do
<<-FILE
@mixin clear_left {
  float: left; clear: both;
}
FILE
end

run 'sass public/stylesheets/sass/main.scss public/stylesheets/main.css'
