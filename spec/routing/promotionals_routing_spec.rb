require "spec_helper"

describe PromotionalsController do
  describe "routing" do

    it "routes to #index" do
      get("/promotionals").should route_to("promotionals#index")
    end

    it "routes to #new" do
      get("/promotionals/new").should route_to("promotionals#new")
    end

    it "routes to #show" do
      get("/promotionals/1").should route_to("promotionals#show", :id => "1")
    end

    it "routes to #edit" do
      get("/promotionals/1/edit").should route_to("promotionals#edit", :id => "1")
    end

    it "routes to #create" do
      post("/promotionals").should route_to("promotionals#create")
    end

    it "routes to #update" do
      put("/promotionals/1").should route_to("promotionals#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/promotionals/1").should route_to("promotionals#destroy", :id => "1")
    end

  end
end
