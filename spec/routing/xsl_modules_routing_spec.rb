require "spec_helper"

describe XslModulesController do
  describe "routing" do

    it "routes to #index" do
      get("/xsl_modules").should route_to("xsl_modules#index")
    end

    it "routes to #new" do
      get("/xsl_modules/new").should route_to("xsl_modules#new")
    end

    it "routes to #show" do
      get("/xsl_modules/1").should route_to("xsl_modules#show", :id => "1")
    end

    it "routes to #edit" do
      get("/xsl_modules/1/edit").should route_to("xsl_modules#edit", :id => "1")
    end

    it "routes to #create" do
      post("/xsl_modules").should route_to("xsl_modules#create")
    end

    it "routes to #update" do
      put("/xsl_modules/1").should route_to("xsl_modules#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/xsl_modules/1").should route_to("xsl_modules#destroy", :id => "1")
    end

  end
end
