# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version
v2.6.3

* System dependencies
redis
sqlite
ruby and bundle

* Configuration
## Install
```
bundle install --path vendor/bundle
# comment out `devise_for` block in `config/routes.rb`
rails credentials:edit
bin/spring binstub --all
bin/rails db:migrate
RAILS_ENV=test bin/rails db:migrate
```
## Run server and confirm seed account
create two console
and run each commands on each console

```
# console A
redis-server
```

```
# console B
rails s
```

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
