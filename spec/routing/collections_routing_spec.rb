require "spec_helper"

describe CollectionsController do
  describe "routes to specific collection landing pages" do
    it 'routes /wcvb and /WCVB to collections#wcvb' do
      expect(:get => "/wcvb").to route_to 'collections#wcvb'
      expect(:get => "/WCVB").to route_to 'collections#wcvb'
    end

    it "routes /wgbh and /WGBH to collections#wgbh" do
      expect(:get => "/wgbh").to route_to 'collections#wgbh'
      expect(:get => "/WGBH").to route_to 'collections#wgbh'
    end

    it "routes /whdh and /WHDH to collections#whdh" do
      expect(:get => "/whdh").to route_to 'collections#whdh'
      expect(:get => "/WHDH").to route_to 'collections#whdh'
    end

    it "routes /cctv and /CCTV to collections#cctv" do
      expect(:get => "/cctv").to route_to 'collections#cctv'
      expect(:get => "/CCTV").to route_to 'collections#cctv'
    end
  end
end
