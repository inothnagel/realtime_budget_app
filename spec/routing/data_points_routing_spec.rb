require "spec_helper"

describe DataPointsController do
  describe "routing" do

    it "routes to #index" do
      get("/data_points").should route_to("data_points#index")
    end

    it "routes to #new" do
      get("/data_points/new").should route_to("data_points#new")
    end

    it "routes to #show" do
      get("/data_points/1").should route_to("data_points#show", :id => "1")
    end

    it "routes to #edit" do
      get("/data_points/1/edit").should route_to("data_points#edit", :id => "1")
    end

    it "routes to #create" do
      post("/data_points").should route_to("data_points#create")
    end

    it "routes to #update" do
      put("/data_points/1").should route_to("data_points#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/data_points/1").should route_to("data_points#destroy", :id => "1")
    end

  end
end
