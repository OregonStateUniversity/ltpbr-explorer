# Beaver Dam Analogue (BDA) Explorer

Beaver Dam Analogues (BDAs) are one low cost, 'cheap and cheerful' technique
used in beaver-assisted restoration to mimic natural beaver dams, promote beaver
to work in particular areas, and accelerate recovery of incised channels.

This application enables users to add BDA their projects to a map, and browse
other BDA projects.

## Development

This is a Rails application. After cloning the repository, you can:

* Install dependencies with `bundle install`.
* Set up the database with `rails db:setup`.
* Run the tests with `rake` or `rspec`.
* Run the server in _development_ with `rails server`.

Requires PostgreSQL with the PostGIS extension available for enabling. You
[may](https://github.com/rgeo/activerecord-postgis-adapter/issues/190) also need
to install _geos_, via `brew install geos`.

Uses the [mapbox](https://www.mapbox.com) API, which requires a public token,
which is hard-coded in some of the js files.

&copy; 2017 Nathan Struhs, Yong Bakos. All rights reserved.
