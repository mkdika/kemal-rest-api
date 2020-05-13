require "micrate"
require "pg"

ENV["DB_URL"] ||= "postgres://postgres:postgres@localhost:5432/kemal_rest_api"

db_root_url = ENV["DB_URL"].split("/")[0..-2].join("/")

DB.connect(db_root_url) do |cnn|
  cnn.exec(
    <<-SQL
      CREATE DATABASE kemal_rest_api;
    SQL
  )
end

Micrate::DB.connection_url = ENV["DB_URL"]
Micrate::Cli.run_up