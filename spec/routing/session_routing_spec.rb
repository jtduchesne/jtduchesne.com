require "rails_helper"

RSpec.describe SessionController, type: :routing do
  describe "FR routing" do
    let(:é) { "%C3%A9" }
    it { expect(get:    "/connexion").to   route_to("session#new",     locale: "fr") }
    it { expect(post:   "/connexion").to   route_to("session#create",  locale: "fr") }
    it { expect(delete: "/connexion").to   route_to("session#destroy", locale: "fr") }
    
    it { expect(get: "/d#{é}connexion").to route_to("session#destroy", locale: "fr") }
  end
  
  describe "EN routing" do
    it { expect(get:    "/login").to route_to("session#new",     locale: "en") }
    it { expect(post:   "/login").to route_to("session#create",  locale: "en") }
    it { expect(delete: "/login").to route_to("session#destroy", locale: "en") }
    
    it { expect(get: "/logout").to route_to("session#destroy", locale: "en") }
  end
end
