require "kemal"

module Kemal::Rest::Api
  VERSION = "0.1.0"

  get "/ping" do
    "PONG"
  end

  Kemal.run
end
