require "rails_helper"

RSpec.describe Admin::ProjectsController, type: :routing do
  describe "FR routing" do
    it { expect(get: "/admin/projets").to   route_to("admin/projects#index", locale: "fr") }
    it { expect(get: "/admin/projets/1").to route_to("admin/projects#show",  locale: "fr", id: "1") }
    
    it { expect(get:  "/admin/projets/nouveau").to route_to("admin/projects#new",    locale: "fr") }
    it { expect(post: "/admin/projets").to         route_to("admin/projects#create", locale: "fr") }
    
    it { expect(get:   "/admin/projets/1/modifier").to route_to("admin/projects#edit",   locale: "fr", id: "1") }
    it { expect(put:   "/admin/projets/1").to          route_to("admin/projects#update", locale: "fr", id: "1") }
    it { expect(patch: "/admin/projets/1").to          route_to("admin/projects#update", locale: "fr", id: "1") }
    
    it { expect(delete: "/admin/projets/1").to route_to("admin/projects#destroy", locale: "fr", id: "1") }
  end
  
  describe "EN routing" do
    it { expect(get: "/admin/projects").to   route_to("admin/projects#index", locale: "en") }
    it { expect(get: "/admin/projects/1").to route_to("admin/projects#show",  locale: "en", id: "1") }
    
    it { expect(get:  "/admin/projects/new").to route_to("admin/projects#new",    locale: "en") }
    it { expect(post: "/admin/projects").to     route_to("admin/projects#create", locale: "en") }
    
    it { expect(get:   "/admin/projects/1/edit").to route_to("admin/projects#edit",   locale: "en", id: "1") }
    it { expect(put:   "/admin/projects/1").to      route_to("admin/projects#update", locale: "en", id: "1") }
    it { expect(patch: "/admin/projects/1").to      route_to("admin/projects#update", locale: "en", id: "1") }
    
    it { expect(delete: "/admin/projects/1").to route_to("admin/projects#destroy", locale: "en", id: "1") }
  end
end
