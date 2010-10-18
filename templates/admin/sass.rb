create_file 'public/stylesheets/sass/admin.scss' do
<<-FILE
@mixin layout_base {
  @include reset;
  @include container;
  @include user_admin_nav;
  @include main_admin_nav;
  //uncomment for a handy layout guide
  @include layout_guide;
}

@mixin reset {
  /*
    html5doctor.com Reset Stylesheet (Eric Meyer's Reset Reloaded + HTML5 baseline)
    v1.4 2009-07-27 | Authors: Eric Meyer & Richard Clark
    html5doctor.com/html-5-reset-stylesheet/
  */

  html, body, div, span, object, iframe,
  h1, h2, h3, h4, h5, h6, p, blockquote, pre,
  abbr, address, cite, code,
  del, dfn, em, img, ins, kbd, q, samp,
  small, strong, sub, sup, var,
  b, i,
  dl, dt, dd, ol, ul, li,
  fieldset, form, label, legend,
  table, caption, tbody, tfoot, thead, tr, th, td,
  article, aside, canvas, details, figcaption, figure,
  footer, header, hgroup, menu, nav, section, summary,
  time, mark, audio, video {
    margin:0;
    padding:0;
    border:0;
    outline:0;
    font-size:100%;
    vertical-align:baseline;
    background:transparent;
  }

  article, aside, details, figcaption, figure,
  footer, header, hgroup, menu, nav, section {
      display:block;
  }

  nav ul { list-style:none; }

  blockquote, q { quotes:none; }

  blockquote:before, blockquote:after,
  q:before, q:after { content:''; content:none; }

  a { margin:0; padding:0; font-size:100%; vertical-align:baseline; background:transparent; }

  ins { background-color:#ff9; color:#000; text-decoration:none; }

  mark { background-color:#ff9; color:#000; font-style:italic; font-weight:bold; }

  del { text-decoration: line-through; }

  abbr[title], dfn[title] { border-bottom:1px dotted; cursor:help; }

  /* tables still need cellspacing="0" in the markup */
  table { border-collapse:collapse; border-spacing:0; }

  hr { display:block; height:1px; border:0; border-top:1px solid #ccc; margin:1em 0; padding:0; }

  input, select { vertical-align:middle; }
}

@mixin clear_left {
  float: left; clear: both;
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
	#main_admin_header {
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
    #main_admin_footer, #pusher {
      height: 80px;
      clear:both;
    }
}

@mixin user_admin_nav {
  #user_admin_nav {
    float: right;
    padding: 20px 0 0 0;
  }
}

@mixin main_admin_nav {
  #main_admin_nav {
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
  #main_admin_header { background-color: #f7dddd; }
  #main_admin_nav { background-color: #f4ddf7; }
  #content { background-color: #f2f7dd; }
  #main_admin_footer .inner { background-color: #ddf7e7; }
}

@include layout_base;
FILE
end

run 'sass public/stylesheets/sass/admin.scss public/stylesheets/admin.css'