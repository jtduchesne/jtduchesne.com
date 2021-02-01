require "rails_helper"

RSpec.describe ProjectsController, type: :routing do
  describe "FR routing" do
    it { expect(get: "/projets").to   route_to("projects#index", locale: "fr") }
    it { expect(get: "/projets/1").to route_to("projects#show",  locale: "fr", id: "1") }
    
    it { expect(get:  "/projets/nouveau").to route_to("projects#new",    locale: "fr") }
    it { expect(post: "/projets").to         route_to("projects#create", locale: "fr") }
    
    it { expect(get:   "/projets/1/modifier").to route_to("projects#edit",   locale: "fr", id: "1") }
    it { expect(put:   "/projets/1").to          route_to("projects#update", locale: "fr", id: "1") }
    it { expect(patch: "/projets/1").to          route_to("projects#update", locale: "fr", id: "1") }
    
    it { expect(delete: "/projets/1").to route_to("projects#destroy", locale: "fr", id: "1") }
  end
  
  describe "EN routing" do
    it { expect(get: "/projects").to   route_to("projects#index", locale: "en") }
    it { expect(get: "/projects/1").to route_to("projects#show",  locale: "en", id: "1") }
    
    it { expect(get:  "/projects/new").to route_to("projects#new",    locale: "en") }
    it { expect(post: "/projects").to     route_to("projects#create", locale: "en") }
    
    it { expect(get:   "/projects/1/edit").to route_to("projects#edit",   locale: "en", id: "1") }
    it { expect(put:   "/projects/1").to      route_to("projects#update", locale: "en", id: "1") }
    it { expect(patch: "/projects/1").to      route_to("projects#update", locale: "en", id: "1") }
    
    it { expect(delete: "/projects/1").to route_to("projects#destroy", locale: "en", id: "1") }
  end
end
