require 'spec_helper'

describe CatalogController do


  describe 'GET search' do

    # basic test to make sure we don't introduce errors
    it 'does not result in error' do
      get :index, q: "whatever"
      response.status.should == 200
    end
  end
end