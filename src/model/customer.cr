require "pg"
require "crecto"

class Customer < Crecto::Model
  schema "customers" do
    field :name, String
    field :email, String
    field :balance, Float64, default: 0.0
  end

  validates :name,
    presence: true,
    length: {min: 2, max: 100}

  validates :email,
    presence: true,
    format: {pattern: /^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$/},
    length: {min: 5, max: 80}
end