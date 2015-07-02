require 'spec_helper'

describe ErrorsController do

  describe "#file_not_found" do
    it "returns http success" do
      get 'file_not_found'
      expect(response).to be_success
    end
  end

  describe "#unprocessable" do
    it "returns http success" do
      get 'unprocessable'
      expect(response).to be_success
    end
  end

  describe "#internal_server_error" do
    it "returns http success" do
      get 'internal_server_error'
      expect(response).to be_success
    end
  end

  describe "#access_denied" do
    it "returns http success" do
      get 'access_denied'
      expect(response).to be_success
    end
  end
end