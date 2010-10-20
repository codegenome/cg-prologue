Prologue
===========
Generate a Rails 3 app with the application templates Quick Left uses to start their projects off right!


### What you get

Prologue provides a base Rails 3 application with Devise and Cancan for authentication and authorization.  Roles are
stored in the database with a HABTM relationship between the role and user models.  You also get a basic admin to manage
users.  Prologue also rolls in all of the things we like to have setup in our apps like...
haml, sass, jquery, cucumber, capybara, mocha, factory_girl, rspec, timecop, autotest, will_paginate, friendly_id, and hoptoad_notifier

Everything is configured and ready to rock your next Rails 3 project.  We hope it saves you a mess of time!


### Quick Start

    gem install prologue

    prologue new my_app


### Options

    prologue new my_app --no-auth

    prologue new my_app --no-roles

    prologue new my_app --no-admin


### Testing generated app

    rake spec
    rake cucumber
    bundle exec autotest


### Issues

Please report issues to the [Prologue issue tracker](http://github.com/quickleft/prologue/issues/).


### Development

    bundle install
    bundle exec cucumber

Running `bundle exec cucumber` will take some time.  It runs the CLI tool with different option combinations and tests
those outputs with aruba.


### Patches/Pull Requests

* Fork it.
* Add tests for it.
* Make your changes.
* Commit.
* Send a pull request.


### Thanks

All of the contributors to the many awesome open source projects that make up prologue and allow us to do our job everyday.
Also, thanks go out to the crew at thoughtbot for writing suspenders.  It's what gave us the idea to package up our
templates into a gem in the first place.


### Copyright

Copyright (c) 2010 Quick Left. See LICENSE for details.

