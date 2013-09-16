require "spec_helper"

describe CatalogController do
  describe "routing" do

    it "routes to #index" do
      get("/catalog").should route_to("catalog#index")
    end

  end
end
