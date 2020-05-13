require "crecto"

module Repository
  extend Crecto::Repo

  ENV["DB_URL"] ||= "postgres://postgres:postgres@localhost:5432/kemal_rest_api?initial_pool_size=2&max_pool_size=5"

  config do |conf|
    conf.adapter = Crecto::Adapters::Postgres
    conf.uri = ENV["DB_URL"]
  end
end