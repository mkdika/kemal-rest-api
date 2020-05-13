require "json"
require "kemal"
require "./repository.cr"
require "./model/*"
require "./controller/*"

module Server
  VERSION = "0.1.0"
  port = ARGV[0]?.try &.to_i?
  Kemal.run port
end
