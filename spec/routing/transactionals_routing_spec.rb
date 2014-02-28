require "spec_helper"

describe TransactionalsController do
  describe "routing" do

    it "routes to #index" do
      get("/transactionals").should route_to("transactionals#index")
    end

    it "routes to #new" do
      get("/transactionals/new").should route_to("transactionals#new")
    end

    it "routes to #show" do
      get("/transactionals/1").should route_to("transactionals#show", :id => "1")
    end

    it "routes to #edit" do
      get("/transactionals/1/edit").should route_to("transactionals#edit", :id => "1")
    end

    it "routes to #create" do
      post("/transactionals").should route_to("transactionals#create")
    end

    it "routes to #update" do
      put("/transactionals/1").should route_to("transactionals#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/transactionals/1").should route_to("transactionals#destroy", :id => "1")
    end

  end
end
