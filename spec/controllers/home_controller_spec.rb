require 'spec_helper'

describe HomeController do

  describe "#index" do
    it "returns http success" do
      get 'index'
      expect(response).to be_success
    end
  end

end
