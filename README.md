# Kemal REST API

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](/LICENSE)
[![Built with Crystal](https://img.shields.io/badge/built%20with-crystal-000000.svg?style=flat-square)](https://crystal-lang.org/)
[![Build Status](https://travis-ci.org/mkdika/kemal-rest-api.svg?branch=master)](https://travis-ci.org/mkdika/kemal-rest-api)

Simple REST API example with [Kemal](https://kemalcr.com/) micro web framework, in CRUD use cases.

## Features

- [Crecto](https://github.com/Crecto/crecto), Database wrapper and ORM for Crystal.
- [Micrate](https://github.com/amberframework/micrate), database migration tool for Crystal.
- Database use PostgreSQL.
- Test specs example.

## Endpoints

| HTTP Method | Path                | Description                          |
| ----------- | ------------------- | ------------------------------------ |
| GET         | /api/customers      | Get all existing customer data       |
| GET         | /api/customers/:id  | Get existing customer data by Id     |
| POST        | /api/customers      | Insert new customer data             |
| PUT         | /api/customers/:id  | update existing customer data by Id  |
| DELETE      | /api/customers/:id  | Delete existing customer data by Id  |

## Build and run on local

Install [Crystal](https://crystal-lang.org/install/) language.

```bash
# Clone the project
git clone https://github.com/mkdika/kemal-rest-api.git
cd kemal-rest-api/

# Install related dependencies
shards install

# create environment variable, you can adjust your db connection string
export DB_URL='postgres://postgres:postgres@localhost:5432/kemal_rest_api'

# Run db setup (create db & run migrations)
crystal run src/util/db_setup.cr

# Run all test specs
crystal spec

# Build binary
shards build --production --release

# run the app
./bin/server
# output: [development] Kemal is ready to lead at http://0.0.0.0:3000

# Optionally, run kemal in `production` environmen & custom port
KEMAL_ENV=production ./bin/server 80
# output: [production] Kemal is ready to lead at http://0.0.0.0:80
```

## Contributing

1. Fork it (<https://github.com/mkdika/kemal-rest-api/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Maikel Chandika](https://github.com/mkdika) - creator and maintainer

## Copyright and License

Copyright 2020 Maikel Chandika (mkdika@gmail.com). Code released under the MIT License. See [LICENSE](/LICENSE) file.
