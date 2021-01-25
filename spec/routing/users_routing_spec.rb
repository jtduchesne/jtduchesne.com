require "rails_helper"

RSpec.describe Admin::UsersController, type: :routing do
  describe "FR routing" do
    it { expect(get: "/admin/utilisateurs").to   route_to("admin/users#index", locale: "fr") }
    it { expect(get: "/admin/utilisateurs/1").to route_to("admin/users#show",  locale: "fr", id: "1") }
    
    it { expect(get:  "/admin/utilisateurs/nouveau").to route_to("admin/users#new",    locale: "fr") }
    it { expect(post: "/admin/utilisateurs").to         route_to("admin/users#create", locale: "fr") }
    
    it { expect(get:   "/admin/utilisateurs/1/modifier").to route_to("admin/users#edit",   locale: "fr", id: "1") }
    it { expect(put:   "/admin/utilisateurs/1").to          route_to("admin/users#update", locale: "fr", id: "1") }
    it { expect(patch: "/admin/utilisateurs/1").to          route_to("admin/users#update", locale: "fr", id: "1") }
    
    it { expect(delete: "/admin/utilisateurs/1").to route_to("admin/users#destroy", locale: "fr", id: "1") }
  end
  
  describe "EN routing" do
    it { expect(get: "/admin/users").to   route_to("admin/users#index", locale: "en") }
    it { expect(get: "/admin/users/1").to route_to("admin/users#show",  locale: "en", id: "1") }
    
    it { expect(get:  "/admin/users/new").to route_to("admin/users#new",    locale: "en") }
    it { expect(post: "/admin/users").to     route_to("admin/users#create", locale: "en") }
    
    it { expect(get:   "/admin/users/1/edit").to route_to("admin/users#edit",   locale: "en", id: "1") }
    it { expect(put:   "/admin/users/1").to      route_to("admin/users#update", locale: "en", id: "1") }
    it { expect(patch: "/admin/users/1").to      route_to("admin/users#update", locale: "en", id: "1") }
    
    it { expect(delete: "/admin/users/1").to route_to("admin/users#destroy", locale: "en", id: "1") }
  end
end
