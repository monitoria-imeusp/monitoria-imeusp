require 'spec_helper'

describe ErrorsController do

  describe "GET 'file_not_found'" do
    it "returns http success" do
      get 'file_not_found'
      response.should be_success
    end
  end

  describe "GET 'unprocessable'" do
    it "returns http success" do
      get 'unprocessable'
      response.should be_success
    end
  end

  describe "GET 'internal_server_error'" do
    it "returns http success" do
      get 'internal_server_error'
      response.should be_success
    end
  end

  describe "GET 'access_denied'" do
    it "returns http success" do
      get 'access_denied'
      response.should be_success
    end
  end

end
