require 'spec_helper'

describe SystemController do

  describe "GET 'candidature_index'" do
    it "returns http success" do
      get 'candidature_index'
      response.should be_success
    end
  end

end
