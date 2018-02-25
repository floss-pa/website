# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version
  Minumal Ruby version is 2.2
* System dependencies
  On centos we require this packages:
   openssl, libyaml, libffi, zlib, gcc, make, readline-devel, ncurses-devel, gdbm-devel, glibc-devel, openssl-devel, libyaml-devel, libffi-devel, zlib-devel, mariadb-devel, ImageMagick
   This is necesary to build all gems
* Configuration
  You need to add this enviroment variables:
   DATABASE_URL="mysql2://user:password@localhost/database_name"
   RAILS_ENV="production"
   You need to generate your secret key, using rails command : bundle exec rails secret
   SECRET_KEY_BASE=""
   Your facebook Application keys
   FB_ID=""
   FB_TOKEN=""
   Your Github Applications keys
   GH_ID=""
   GH_TOKEN=""
   RAILS_SERVE_STATIC_FILES=false
   Your email password
   EMAIL_SERVER_ADDRESS
   EMAIL_USER=""
   EMAIL_PASSWORD=""
  All this variables must be exported and set on the user that will run your app.
* Database creation
   to create the database run:
   bundle exec rails db:setup
* Database initialization
  to initalize the database:
   bundle exec rails db:migrate
* Generate your assets
  bundle exec rails assets:precompile  RAILS_ENV=production
* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)
  no jobs for now.
* Deployment instructions

* ...
