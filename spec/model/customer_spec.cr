require "../spec_helper"
require "../../src/model/customer"
require "../../src/repository"

describe Customer do
  after_each do
    Repository.delete_all Customer
  end

  describe "column" do
    it "should have columns" do
      customer = Customer.new
      customer.name = "Maikel"
      customer.email = "mkdika@gmail.com"
      customer.balance = 99.9

      changeset = Repository.insert customer
      changeset.errors.any?.should be_false
    end
  end

  describe "validation" do
    it "should validate presence" do
      customer = Customer.new

      changeset = Repository.insert customer
      changeset.errors.any?.should be_true
      changeset.valid?.should be_false
      error_fields = changeset.errors.map { |t| t[:field] }
      error_fields.includes?("name").should be_true
      error_fields.includes?("email").should be_true
    end

    it "should validate email format" do
      customer = Customer.new
      customer.name = "Budi"
      customer.email = "wrong_email@mail_format"

      changeset = Repository.insert customer
      changeset.errors.any?.should be_true
      changeset.valid?.should be_false
      error_fields = changeset.errors.map { |t| t[:field] }
      error_fields.includes?("name").should be_false
      error_fields.includes?("email").should be_true
    end
  end
end
