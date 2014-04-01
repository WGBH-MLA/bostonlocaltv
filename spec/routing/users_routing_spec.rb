require "spec_helper"

describe UsersController do
  describe "routing" do

    it "routes to users#show" do
      get("/dashboard").should route_to("users#show")
    end

  end
end
