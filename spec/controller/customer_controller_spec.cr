require "json"
require "http/headers"
require "../spec_helper"
require "../../src/server"
require "../../src/repository"
require "../../src/model/customer"

describe "CustomerController" do
  describe "GET /api/customers" do
    after_each do
      Repository.delete_all Customer
    end

    it "should return 200 and array of customer when data is exists" do
      sample = create_sample_customer.instance

      get "/api/customers"

      response.status_code.should eq 200
      body = Array(Customer).from_json(response.body)
      typeof(body).should eq Array(Customer)
      body.size.should eq 1
      body[0].name.should eq sample.name
      body[0].email.should eq sample.email
      body[0].balance.should eq sample.balance
    end

    it "should return 200 and empty array when data is NOT exists" do
      get "/api/customers"

      response.status_code.should eq 200
      response.body.should eq "[]"
      body = Array(Customer).from_json(response.body)
      typeof(body).should eq Array(Customer)
      body.size.should eq 0
    end
  end

  describe "GET /api/customers/:id" do
    after_each do
      Repository.delete_all Customer
    end

    it "should return 200 and customer object when data is exists" do
      sample = create_sample_customer.instance

      get "/api/customers/#{sample.id}"

      response.status_code.should eq 200
      body = Customer.from_json(response.body)
      body.name.should eq sample.name
      body.email.should eq sample.email
      body.balance.should eq sample.balance
    end

    it "should return 404 when id is NOT exists" do
      not_exists_id = 9999

      get "/api/customers/#{not_exists_id}"

      response.status_code.should eq 404
    end
  end

  describe "POST /api/customers" do
    after_each do
      Repository.delete_all Customer
    end

    it "should return 200 and customer object when payload is valid" do
      data = Customer.new
      data.name = "Maikel"
      data.email = "mkdika@gmail.com"
      data.balance = 9.9
      headers = HTTP::Headers{"Content-Type" => "application/json"}

      post "/api/customers", headers: headers, body: data.to_json

      response.status_code.should eq 200
      response.body.nil?.should be_false
      response_body = Customer.from_json(response.body)
      response_body.id.nil?.should be_false
      response_body.name.should eq data.name
      response_body.email.should eq data.email
      response_body.balance.should eq data.balance
    end

    it "should return 406 and error body when payload is NOT valid" do
      data = Customer.new
      data.name = "Maikel"
      data.email = ""
      data.balance = 9.9
      headers = HTTP::Headers{"Content-Type" => "application/json"}

      post "/api/customers", headers: headers, body: data.to_json

      response.status_code.should eq 406
      response.body.nil?.should be_false
    end
  end

  describe "PUT /api/customers/:id" do
    after_each do
      Repository.delete_all Customer
    end

    it "should return 200 and customer object when payload is valid" do
      sample = create_sample_customer.instance
      headers = HTTP::Headers{"Content-Type" => "application/json"}
      sample.name = "jack"
      sample.email = "abc@xyz.com"

      put "/api/customers/#{sample.id}", headers: headers, body: sample.to_json

      response.status_code.should eq 200
      response.body.nil?.should be_false
      response_body = Customer.from_json(response.body)
      response_body.name.should eq sample.name
      response_body.email.should eq sample.email
    end

    it "should return 406 when payload is NOT valid" do
      sample = create_sample_customer.instance
      headers = HTTP::Headers{"Content-Type" => "application/json"}
      sample.name = ""
      sample.email = ""

      put "/api/customers/#{sample.id}", headers: headers, body: sample.to_json

      response.status_code.should eq 406
      response.body.nil?.should be_false
    end
  end

  describe "DELETE /api/customers/:id" do
    after_each do
      Repository.delete_all Customer
    end

    it "should return 204 when success delete" do
      sample = create_sample_customer.instance

      delete "/api/customers/#{sample.id}"

      response.status_code.should eq 204
    end

    it "should return 404 when id is NOT exists" do
      not_exists_id = 9999

      delete "/api/customers/#{not_exists_id}"

      response.status_code.should eq 404
    end
  end
end

def create_sample_customer
  c = Customer.new
  c.name = "Budi"
  c.email = "budi@email.com"
  c.balance = 99.9
  Repository.insert c
end
