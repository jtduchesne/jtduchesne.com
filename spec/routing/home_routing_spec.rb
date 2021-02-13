require 'rails_helper'

RSpec.describe HomeController, type: :routing do
  describe "routing" do
    it { expect(get: '/').to route_to("home#posts") }
    it { expect(get: '/fr').to route_to("home#posts", locale: "fr") }
    it { expect(get: '/en').to route_to("home#posts", locale: "en") }
    
    it { expect(get: '/blog-post').to route_to("home#post", id: "blog-post") }
    
    it { expect(get: "/projets").to   route_to("home#projects", locale: "fr") }
    it { expect(get: "/projets/1").to route_to("home#project",  locale: "fr", id: "1") }
    it { expect(get: "/projects").to   route_to("home#projects", locale: "en") }
    it { expect(get: "/projects/1").to route_to("home#project",  locale: "en", id: "1") }
    
    it { expect(get:  "/contacter").to route_to("messages#new",    locale: "fr") }
    it { expect(post: "/contacter").to route_to("messages#create", locale: "fr") }
    it { expect(get:  "/contact").to   route_to("messages#new",    locale: "en") }
    it { expect(post: "/contact").to   route_to("messages#create", locale: "en") }
    
    it { expect(get: "/#{à}-propos").to route_to("home#about", locale: "fr") }
    it { expect(get: "/about").to       route_to("home#about", locale: "en") }
  end
end
