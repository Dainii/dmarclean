DmarClean 
![Rails](https://github.com/dainii/dmarclean/actions/workflows/rubyonrails.yml/badge.svg)
[![codecov](https://codecov.io/gh/Dainii/dmarclean/graph/badge.svg?token=KVGRPG4SLG)](https://codecov.io/gh/Dainii/dmarclean)
=========

DmarClean is a rails based application to analyze and display result of various dmarc report.

## Install

### Clone the repository

```shell
git clone https://github.com/Dainii/dmarclean.git
cd dmarclean
```

### Check your Ruby version

```shell
ruby -v
```

The ouput should start with something like `ruby 3.3.0`

If not, install the right ruby version using [rbenv](https://github.com/rbenv/rbenv) (it could take a while):

```shell
rbenv install 3.3.0
```

### Install dependencies

Using [Bundler](https://github.com/bundler/bundler), install the dependencies:

```shell
bundle install
```

### Set environment variables

Copy `.env.erb` to `.env`.

* Set the Database related variables
* Generate the Active Record encryption keys with `bundle exec rails db:encryption:init`

### Initialize the database

Create the Database
```shell
bundle exec rails db:create
```

Load the schema (first time only)
```shell
bundle exec rails db:schema:load
```

Apply migrations
```shell
bundle exec rails db:migrate db:seed
```

Load seeds
```shell
bundle exec rails db:seed
```

Reset the database (drop + load schema + seed)
```shell
bundle exec rails db:reset
```

## Start application

This will start the web server, the worker and Tailwind app. Details are defined in the `Procfile.dev` file

```shell
./bin/dev
```
