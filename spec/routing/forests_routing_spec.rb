require "rails_helper"

RSpec.describe ForestsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/forests").to route_to("forests#index")
    end

    it "routes to #new" do
      expect(get: "/forests/new").to route_to("forests#new")
    end

    it "routes to #show" do
      expect(get: "/forests/1").to route_to("forests#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/forests/1/edit").to route_to("forests#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/forests").to route_to("forests#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/forests/1").to route_to("forests#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/forests/1").to route_to("forests#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/forests/1").to route_to("forests#destroy", id: "1")
    end
  end
end
