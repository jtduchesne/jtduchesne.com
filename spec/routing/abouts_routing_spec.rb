require "rails_helper"

RSpec.describe Admin::AboutsController, type: :routing do
  describe "FR routing" do
    it { expect(get: "/admin/#{à}-propos").to   route_to("admin/abouts#index", locale: "fr") }
    it { expect(get: "/admin/#{à}-propos/1").to route_to("admin/abouts#show",  locale: "fr", id: "1") }
    
    it { expect(get:  "/admin/#{à}-propos/nouveau").to route_to("admin/abouts#new",    locale: "fr") }
    it { expect(post: "/admin/#{à}-propos").to         route_to("admin/abouts#create", locale: "fr") }
    
    it { expect(get:   "/admin/#{à}-propos/1/modifier").to route_to("admin/abouts#edit",   locale: "fr", id: "1") }
    it { expect(put:   "/admin/#{à}-propos/1").to          route_to("admin/abouts#update", locale: "fr", id: "1") }
    it { expect(patch: "/admin/#{à}-propos/1").to          route_to("admin/abouts#update", locale: "fr", id: "1") }
    
    it { expect(delete: "/admin/#{à}-propos/1").to route_to("admin/abouts#destroy", locale: "fr", id: "1") }
  end
  
  describe "EN routing" do
    it { expect(get: "/admin/abouts").to   route_to("admin/abouts#index", locale: "en") }
    it { expect(get: "/admin/abouts/1").to route_to("admin/abouts#show",  locale: "en", id: "1") }
    
    it { expect(get:  "/admin/abouts/new").to route_to("admin/abouts#new",    locale: "en") }
    it { expect(post: "/admin/abouts").to     route_to("admin/abouts#create", locale: "en") }
    
    it { expect(get:   "/admin/abouts/1/edit").to route_to("admin/abouts#edit",   locale: "en", id: "1") }
    it { expect(put:   "/admin/abouts/1").to      route_to("admin/abouts#update", locale: "en", id: "1") }
    it { expect(patch: "/admin/abouts/1").to      route_to("admin/abouts#update", locale: "en", id: "1") }
    
    it { expect(delete: "/admin/abouts/1").to route_to("admin/abouts#destroy", locale: "en", id: "1") }
  end
end
