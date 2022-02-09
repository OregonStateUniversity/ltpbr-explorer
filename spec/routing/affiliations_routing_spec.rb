require "rails_helper"

RSpec.describe AffiliationsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/affiliations").to route_to("affiliations#index")
    end

    it "routes to #new" do
      expect(get: "/affiliations/new").to route_to("affiliations#new")
    end

    it "routes to #show" do
      expect(get: "/affiliations/1").to route_to("affiliations#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/affiliations/1/edit").to route_to("affiliations#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/affiliations").to route_to("affiliations#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/affiliations/1").to route_to("affiliations#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/affiliations/1").to route_to("affiliations#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/affiliations/1").to route_to("affiliations#destroy", id: "1")
    end
  end
end
