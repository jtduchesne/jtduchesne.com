require "rails_helper"

RSpec.describe PostsController, type: :routing do
  describe "FR routing" do
    it { expect(get: "/articles").to   route_to("posts#index", locale: "fr") }
    it { expect(get: "/articles/1").to route_to("posts#show",  locale: "fr", id: "1") }
    
    it { expect(get:  "/articles/nouveau").to route_to("posts#new",    locale: "fr") }
    it { expect(post: "/articles").to         route_to("posts#create", locale: "fr") }
    
    it { expect(get:   "/articles/1/modifier").to route_to("posts#edit",   locale: "fr", id: "1") }
    it { expect(put:   "/articles/1").to          route_to("posts#update", locale: "fr", id: "1") }
    it { expect(patch: "/articles/1").to          route_to("posts#update", locale: "fr", id: "1") }
    
    it { expect(delete: "/articles/1").to route_to("posts#destroy", locale: "fr", id: "1") }
  end
  
  describe "EN routing" do
    it { expect(get: "/posts").to   route_to("posts#index", locale: "en") }
    it { expect(get: "/posts/1").to route_to("posts#show",  locale: "en", id: "1") }
    
    it { expect(get:  "/posts/new").to route_to("posts#new",    locale: "en") }
    it { expect(post: "/posts").to     route_to("posts#create", locale: "en") }
    
    it { expect(get:   "/posts/1/edit").to route_to("posts#edit",   locale: "en", id: "1") }
    it { expect(put:   "/posts/1").to      route_to("posts#update", locale: "en", id: "1") }
    it { expect(patch: "/posts/1").to      route_to("posts#update", locale: "en", id: "1") }
    
    it { expect(delete: "/posts/1").to route_to("posts#destroy", locale: "en", id: "1") }
  end
end
