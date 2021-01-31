require "rails_helper"

RSpec.describe Admin::MessagesController, type: :routing do
  describe "FR routing" do
    it { expect(get: "/admin/messages/fr").to   route_to("admin/messages#index", locale: "fr") }
    it { expect(get: "/admin/messages/fr/1").to route_to("admin/messages#show",  locale: "fr", id: "1") }
    
    it { expect(get:  "/admin/messages/fr/nouveau").to route_to("admin/messages#new",    locale: "fr") }
    it { expect(post: "/admin/messages/fr").to         route_to("admin/messages#create", locale: "fr") }
    
    it { expect(delete: "/admin/messages/fr/1").to route_to("admin/messages#destroy", locale: "fr", id: "1") }
  end
  
  describe "EN routing" do
    it { expect(get: "/admin/messages/en").to   route_to("admin/messages#index", locale: "en") }
    it { expect(get: "/admin/messages/en/1").to route_to("admin/messages#show",  locale: "en", id: "1") }
    
    it { expect(get:  "/admin/messages/en/new").to route_to("admin/messages#new",    locale: "en") }
    it { expect(post: "/admin/messages/en").to     route_to("admin/messages#create", locale: "en") }
    
    it { expect(delete: "/admin/messages/en/1").to route_to("admin/messages#destroy", locale: "en", id: "1") }
  end
end
