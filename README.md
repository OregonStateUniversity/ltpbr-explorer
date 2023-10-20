# Beaver Dam Analogue (BDA) Explorer

Beaver Dam Analogues (BDAs) are one low cost, 'cheap and cheerful' technique
used in beaver-assisted restoration to mimic natural beaver dams, promote beaver
to work in particular areas, and accelerate recovery of incised channels.

[BDA-Explorer](https://bda-explorer.herokuapp.com/) enables users to add BDA their
projects to a map, and browse other BDA projects.

## Prerequisites
* [Ruby 3.2.2+](https://www.ruby-lang.org)
* [Rails 7.1.1+](https://rubyonrails.org)
* [PostgreSQL + postgresql-contrib](https://www.postgresql.org)
* [PostGIS](https://postgis.net)
* [GEOS](https://libgeos.org)
* [A Javascript runtime supported by Rails (NodeJS recommended)](https://github.com/rails/execjs)

## Setting Up Development Environment

### 1. Setting up the Repository

Clone the repository by running `git clone https://github.com/OregonStateUniversity/bda-explorer.git`
into a directory of your choice.

### 2. Installing gems

Change into the cloned git repository directory and run `bundle install` to install
the required gems and Rails version.

#### 2.1. Installing a PostgreSQL client library 

This is required to build `pg`, one of the gems used in the app; the gem will print
a compilation error and instructions for installing a PostgreSQL client library on
your system, if one is not found.

### 3. Set up database

A role with the current user’s name must created with `psql` with SUPERUSER,
CREATEDB, CREATEROLE, and LOGIN privileges. Create the database with `./bin/rails db:setup`.

#### 3.1. libffi error

[On Ubuntu 20.04](https://askubuntu.com/questions/1377139/loaderror-libffi-so-8-cannot-open-shared-object-file-no-such-file-or-director), a `LoadError` may be thrown involving the `libffi` library. This library can be installed by running
```
wget http://archive.ubuntu.com/ubuntu/pool/main/libf/libffi/libffi8_3.4.2-1ubuntu5_amd64.deb
sudo dpkg -i ./libffi8_3.4.2-1ubuntu5_amd64.deb
```

### 4. Run migrations

Run `./bin/rails db:migrate` to update the database schema.

### 5. Set up App Credentials/Secrets

Obtain a copy of the development.key and/or production.key files (ask a developer).

### 6. Run tests

Run tests with `rake` or `rspec` to ensure the development environment is working properly.

### 7. Run server

With PostgreSQL running, run the server locally with `./bin/rails server`.

### Post-Install Configuration

#### Setting Admin role/privileges

By default, users have the 'public' role, which gives them standard CRUD permissions for projects they make.
Users can be given the 'admin' role from the console, which gives them CRUD permissions for all projects, including projects they did not create, and CRUD permissions for organizations, which normal users do not have.

A user can be given the 'admin' role by running `@user.update_attribute(:role, 'admin')`, where `@user` is the user record you want to give permissions to.

## Set Up Heroku

If you have a Heroku account registered as a contributor for the [bda-explorer](https://dashboard.heroku.com/apps/bda-explorer) and [bda-explorer-staging](https://dashboard.heroku.com/apps/bda-explorer-staging) apps, you can push changes from your local git repository to the live/test version of the website.

### Configure Git

Add the production and staging environments as remote tracked repositories to your local git repository.

Add the production environment by running `git remote add production https://git.heroku.com/bda-explorer.git`.

Add the staging environment by running `git remote add staging https://git.heroku.com/bda-explorer-staging.git`. 

### Pushing to Heroku

Push your current version of `master` by running `git push production master`.

For a feature branch to be tested on staging, run `git push --force staging <BRANCH>:master`, where `<BRANCH>` is the name of the feature branch. The feature branch should not be missing migrations present on the current build of staging.

&copy; 2022 Gatlin Cooper, Chris Miraflor, Nathan Struhs, Yong Bakos. All rights reserved.
