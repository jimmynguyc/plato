# Plato

The Philosophical Project Management Software

Live Demo: https://afternoon-savannah-75781.herokuapp.com/

## Getting started

Setting up DB for the first time

```
$ docker compose run app bin/rails db:setup
$ docker compose up
```

Other times, just do this to start the app

```
$ docker compose up
```

Access app at [http://localhost:3000/](http://localhost:3000)

### Add Users & Organizations

Users & Organizations needs to be added manually for the time being.

```
$ ./bin/dr console

irb> solo_user = User.create!(email: 'foo@plato.com', password: 'abcd1234')

irb> org = Organization.create!(name: 'Best Org Ever', plan: 'startup')
irb> org_user_1 = User.create!(email: 'org1@plato.com', password: 'abcd1234', organization: org)
irb> org_user_2 = User.create!(email: 'org2@plato.com', password: 'abcd1234', organization: org)
...
```

Login using created credentials.


## Working with `docker compose` Helpers

The `bin/dr` and `bin/de` are executables that are shortcuts for running :
- `docker compose exec app rails`
- `docker compose exec app`

E.g. 
```
$ ./bin/dr console
$ ./bin/dr g scaffold Board
$ ./bin/dr db:migrate

$ ./bin/de bundle install
$ ./bin/de bundle exec annotate
```

## Running tests

If you haven't setup the test DBs

```
$ ./bin/de RAILS_ENV=test rails db:setup 
```

Run tests

```
$ ./bin/dr test
```

## Subscription Service Objects

- app/services/base.rb
- app/services/solo.rb
- app/services/startup.rb
- app/services/business.rb

Example usage:

```ruby
Subscription::Solo.new(organization: nil, duration: 12.months).amount_due
Subscription::Startup.new(organization: org, duration: 12.months).amount_due
Subscription::Business.new(organization: org, duration: 12.months).amount_due
```


## ERD

https://dbdiagram.io/d/61c221973205b45b73c7cfbf

## Architectural Decisions

- Rely on [Turbo](https://turbo.hotwired.dev/) and [Stimulus](https://stimulus.hotwired.dev/) as much as possible
- Use [TailwindCSS](https://tailwindcss.com/) via [CSS Bundling](https://github.com/rails/cssbundling-rails)
- Use `docker compose` as local development setup
