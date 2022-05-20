require "rails_helper"

RSpec.describe AffiliationsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/projects/1/affiliations").to route_to("affiliations#index", project_id: "1")
    end

    it "routes to #new" do
      expect(get: "/projects/1/affiliations/new").to route_to("affiliations#new", project_id: "1")
    end

    it "routes to #show" do
      expect(get: "/projects/1/affiliations/1").to route_to("affiliations#show", id: "1", project_id: "1")
    end

    it "routes to #edit" do
      expect(get: "/projects/1/affiliations/1/edit").to route_to("affiliations#edit", id: "1", project_id: "1")
    end


    it "routes to #create" do
      expect(post: "/projects/1/affiliations").to route_to("affiliations#create", project_id: "1")
    end

    it "routes to #update via PUT" do
      expect(put: "/projects/1/affiliations/1").to route_to("affiliations#update", id: "1", project_id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/projects/1/affiliations/1").to route_to("affiliations#update", id: "1", project_id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/projects/1/affiliations/1").to route_to("affiliations#destroy", id: "1", project_id: "1")
    end
  end
end
