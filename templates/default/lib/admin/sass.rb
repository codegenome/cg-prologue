empty_directory "app/assets/stylesheets/admin"

create_file 'app/assets/stylesheets/admin.css.scss' do
<<-FILE
/*
 *= require ./reset
 *= require_self
 *= require_tree ./admin
 */

@import "partials/*";

@mixin admin {
  @include fonts;
  @include defaults;
  @include media;
}
@include admin;
FILE
end
