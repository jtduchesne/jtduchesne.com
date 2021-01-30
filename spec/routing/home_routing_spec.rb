require 'rails_helper'

RSpec.describe HomeController, type: :routing do
  describe "routing" do
    it { expect(get: '/').to route_to("home#index") }
    it { expect(get: '/fr').to route_to("home#index", locale: "fr") }
    it { expect(get: '/en').to route_to("home#index", locale: "en") }
    
    let(:à) { "%C3%A0" }
    it { expect(get: "/#{à}-propos").to route_to("home#about", locale: "fr") }
    it { expect(get: "/about").to       route_to("home#about", locale: "en") }
  end
end
