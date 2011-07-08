empty_directory "app/assets/stylesheets/partials"
empty_directory "app/assets/stylesheets/main"

create_file 'app/assets/stylesheets/main.css.scss' do
<<-FILE
/*
 *= require ./reset
 *= require_self
 *= require_tree ./main
 */

@import "partials/*";

@mixin main {
  @include fonts;
  @include defaults;
  @include media;
}
@include main;
FILE
end

create_file 'app/assets/stylesheets/partials/_variables.css.scss' do
<<-FILE
$base-font-family: unquote('sans-serif');  // default font-family

$base-font-size: 13px;  // default font-size for YUI fonts

$base-line-height: 1.231;  // default line-height for YUI fonts

$font-color: #444;

$link-color: #607890;

$link-hover-color: #036;

$link-active-color: #607890;

$link-visited-color: #607890;

$selected-font-color: #fff;  // color for selected text

$selected-background-color: #ff5E99;  // bg-color for selected text

$list-left-margin: 1.8em;  // left margin for ul an ol
FILE
end

create_file 'app/assets/stylesheets/partials/_fonts.css.scss' do
<<-FILE
$base-font-family: unquote("sans-serif") !default;
$base-font-size: 13px !default;
$base-line-height: 1.231 !default;

//
// fonts.css from the YUI Library: developer.yahoo.com/yui/
//
// There are three custom edits:
// * remove arial, helvetica from explicit font stack
// * we normalize monospace styles ourselves
// * table font-size is reset in the HTML5 reset above so there is no need to repeat
//
// Whatever parts of this port of YUI to Sass that are copyrightable, are Copyright (c) 2008, Christopher Eppstein. All Rights Reserved.
//

@mixin fonts($family: $base-font-family, $size: $base-font-size, $line-height: $base-line-height) {
  body {
    font-size: $size;
    font-family: $family;
    line-height: $line-height; // hack retained to preserve specificity
    *font-size: small;
  }

  select, input, textarea, button { font: 99% $family; }

  // normalize monospace sizing
  // meyerweb.com/eric/thoughts/2010/02/12/fixed-monospace-sizing/
  // en.wikipedia.org/wiki/MediaWiki_talk:Common.css/Archive_11#Teletype_style_fix_for_Chrome
  pre, code, kbd, samp { font-family: monospace, sans-serif; }
}

// maxvoltar.com/archive/-webkit-font-smoothing
@mixin font-smoothing {
  -webkit-font-smoothing: antialiased;
}

// Sets the font size specified in pixels using percents so that the base
// font size changes and 1em has the correct value. When nesting font size
// declarations, within the DOM tree, the base_font_size must be the parent's
// effective font-size in pixels.
// Usage Examples:
//   .big
//     +font-size(16px)
//   .bigger
//     +font-size(18px)
//   .big .bigger
//     +font-size(18px, 16px)
//
// For more information see the table found at http://developer.yahoo.com/yui/3/cssfonts/#fontsize
@mixin font-size($size, $base-font-size: $base-font-size) {
  font-size: ceil(percentage($size / $base-font-size));
}
FILE
end

create_file 'app/assets/stylesheets/partials/_media.css.scss' do
<<-FILE
@mixin media {
  @media print {
    @include media-print;
  }

  @media all and (orientation:portrait) {
    @include media-orientation-portrait;
  }

  @media all and (orientation:landscape) {
    @include media-orientation-landscape;
  }

  @media screen and (max-device-width: 480px) {
    @include media-mobile;
  }
}

//
// print styles
// inlined to avoid required HTTP connection www.phpied.com/delay-loading-your-print-css/

@mixin media-print {
  * { background: transparent !important; color: black !important; text-shadow: none !important; } /* Black prints faster: sanbeiji.com/archives/953 */
  a, a:visited { color: #444 !important; text-decoration: underline; }
  a[href]:after { content: " (" attr(href) ")"; }
  abbr[title]:after { content: " (" attr(title) ")"; }
  .ir a:after { content: ""; }  /* Don't show links for images */
  pre, blockquote { border: 1px solid #999; page-break-inside: avoid; }
  thead { display: table-header-group; } /* css-discuss.incutio.com/wiki/Printing_Tables */
  tr, img { page-break-inside: avoid; }
  @page { margin: 0.5cm; }
  p, h2, h3 { orphans: 3; widows: 3; }
  h2, h3{ page-break-after: avoid; }
}


//
// Media queries for responsive design
// These follow after primary styles so they will successfully override.
//

@mixin media-orientation-portrait {
  // Style adjustments for portrait mode goes here
}

@mixin media-orientation-landscape {
  // Style adjustments for landscape mode goes here
}

// Grade-A Mobile Browsers (Opera Mobile, iPhone Safari, Android Chrome)
// Consider this: www.cloudfour.com/css-media-query-for-mobile-is-fools-gold/
@mixin media-mobile($optimize: true) {
  // j.mp/textsizeadjust
  @if not $optimize {
    // don't allow iOS and WinMobile to mobile-optimize text
    html { -webkit-text-size-adjust:none; -ms-text-size-adjust:none; }
  }
}
FILE
end

create_file 'app/assets/stylesheets/partials/_defaults.css.scss' do
<<-FILE
$font-color: #444 !default;  //looks better than black: twitter.com/H_FJ/statuses/11800719859
$link-color: #607890 !default;
$link-hover-color: #036 !default;
$link-active-color: #607890 !default;
$link-visited-color: #607890 !default;
$selected-font-color: #fff !default;
$selected-background-color: #ff5e99 !default;
$list-left-margin: 1.8em !default;
//
// Based on Paul Irish's boilerplate sass'd up by sporked.
//
// Minimal base styles
//

@mixin defaults {
  body, select, input, textarea { color: $font-color; }

  html { @include force-scrollbar; }

  a, a:active, a:visited { color: $link-color; }
  a:hover { color: $link-hover-color; }

  ul, ol { margin-left: $list-left-margin; }
  ol { list-style-type: decimal; }

  td, td img { vertical-align: top; }

  sub { @include sub; }

  sup { @include sup; }

  textarea { overflow: auto; }  // thnx ivannikolic! www.sitepoint.com/blogs/2010/08/20/ie-remove-textarea-scrollbars

  @include accessible-focus;

  @include quoted-pre;

  @include align-input-labels;

  @include hand-cursor-inputs;

  @include webkit-reset-form-elements;

  @include selected-text;

  @include webkit-tap-highlight;

  @include ie-hacks;

  @include no-nav-margins;
}

@mixin sub{
  vertical-align: sub; font-size: smaller;
}

@mixin sup{
  vertical-align: super; font-size: smaller;
}

// Accessible focus treatment: people.opera.com/patrickl/experiments/keyboard/test
@mixin accessible-focus {
  a:hover, a:active { outline: none; }
}

// www.pathf.com/blogs/2008/05/formatting-quoted-code-in-blog-posts-css21-white-space-pre-wrap/
@mixin quoted-pre {
  pre {
    padding: 15px;
    white-space: pre;       // CSS2
    white-space: pre-wrap;  // CSS 2.1
    white-space: pre-line;  // CSS 3 (and 2.1 as well, actually)
    word-wrap: break-word;  // IE
  }
}

// align checkboxes, radios, text inputs with their label
// by: Thierry Koblentz tjkdesign.com/ez-css/css/base.css
@mixin align-input-labels {
  input[type="radio"] { vertical-align: text-bottom; }
  input[type="checkbox"] { vertical-align: bottom; }
  .ie7 input[type="checkbox"] { vertical-align: baseline; }
  .ie6 input { vertical-align: text-bottom; }
}

// hand cursor on clickable input elements
@mixin hand-cursor-inputs {
  label, input[type="button"], input[type="submit"], input[type="image"], button { cursor: pointer; }
}

// webkit browsers add a 2px margin outside the chrome of form elements
@mixin webkit-reset-form-elements {
  button, input, select, textarea { margin: 0; }
}

// These selection declarations have to be separate.
// No text-shadow: twitter.com/miketaylr/status/12228805301
// Also: hot pink.
@mixin selected-text {
  ::-moz-selection{ background:$selected-background-color; color: $selected-font-color; text-shadow: none; }
  ::selection { background: $selected-background-color; color: $selected-font-color; text-shadow: none; }
}

// j.mp/webkit-tap-highlight-color
@mixin webkit-tap-highlight {
  a:link { -webkit-tap-highlight-color: $selected-background-color; }
}

// always force a scrollbar in non-IE
@mixin force-scrollbar {
  overflow-y: scroll;
}

@mixin ie-hacks {
  // make buttons play nice in IE:
  // www.viget.com/inspire/styling-the-button-element-in-internet-explorer/
  button {  width: auto; overflow: visible; }

  // bicubic resizing for non-native sized IMG:
  // code.flickr.com/blog/2008/11/12/on-ui-quality-the-little-things-client-side-image-resizing/
  .ie7 img { -ms-interpolation-mode: bicubic; }

  .ie6 legend, .ie7 legend { margin-left: -7px; } // thnx ivannikolic!
}

@mixin no-nav-margins {
  // Remove margins for navigation lists
  nav ul, nav li { margin: 0; }
}
FILE
end
