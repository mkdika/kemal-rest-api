get "/api/customers" do |env|
  env.response.content_type = "application/json"
  customers = Repository.all Customer
  customers.to_json
end

get "/api/customers/:id" do |env|
  id = env.params.url["id"]
  env.response.content_type = "application/json"
  customer = Repository.get Customer, id
  unless customer.nil?
    customer.to_json
  else
    env.response.status_code = 404
  end
end

post "/api/customers" do |env|
  begin
    customer = Customer.new
    customer.name = env.params.json["name"].as(String)
    customer.email = env.params.json["email"].as(String)
    customer.balance = env.params.json["balance"].as(Float64)

    env.response.content_type = "application/json"
    changeset = Repository.insert customer
    if changeset.valid?
      changeset.instance.to_json
    else
      env.response.status_code = 406
      changeset.errors.to_json
    end
  rescue exception
    env.response.status_code = 406
    {error: exception.message}.to_json
  end
end

put "/api/customers/:id" do |env|
  id = env.params.url["id"]
  customer = Repository.get Customer, id
  env.response.content_type = "application/json"
  unless customer.nil?
    customer.name = env.params.json["name"].as(String)
    customer.email = env.params.json["email"].as(String)
    customer.balance = env.params.json["balance"].as(Float64)
    changeset = Repository.update customer
    if changeset.valid?
      changeset.instance.to_json
    else
      env.response.status_code = 406
      changeset.errors.to_json
    end
  else
    env.response.status_code = 404
  end
end

delete "/api/customers/:id" do |env|
  id = env.params.url["id"]
  customer = Repository.get Customer, id
  unless customer.nil?
    Repository.delete customer
    env.response.status_code = 204
  else
    env.response.status_code = 404
  end
end
