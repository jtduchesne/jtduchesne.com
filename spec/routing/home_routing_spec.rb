require 'rails_helper'

RSpec.describe HomeController, type: :routing do
  describe "routing" do
    it { expect(get: '/').to route_to("home#index") }
    it { expect(get: '/fr').to route_to("home#index", locale: "fr") }
    it { expect(get: '/en').to route_to("home#index", locale: "en") }
    
    it { expect(get:  "/contacter").to route_to("messages#new",    locale: "fr") }
    it { expect(post: "/contacter").to route_to("messages#create", locale: "fr") }
    it { expect(get:  "/contact").to   route_to("messages#new",    locale: "en") }
    it { expect(post: "/contact").to   route_to("messages#create", locale: "en") }
    
    it { expect(get: "/#{à}-propos").to route_to("home#about", locale: "fr") }
    it { expect(get: "/about").to       route_to("home#about", locale: "en") }
  end
end
