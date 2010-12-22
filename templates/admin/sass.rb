create_file 'public/stylesheets/sass/admin.scss' do
<<-FILE
@import "partials/admin_variables";
@import "partials/fonts";
@import "partials/defaults";
@import "partials/media";

@mixin admin {
  @include fonts;
  @include defaults;
  @include media;
}
@include admin;
FILE
end

create_file 'public/stylesheets/sass/partials/_admin_variables.scss' do
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

run 'sass public/stylesheets/sass/admin.scss public/stylesheets/admin.css'
