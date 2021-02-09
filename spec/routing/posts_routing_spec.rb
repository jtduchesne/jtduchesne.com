require "rails_helper"

RSpec.describe Admin::PostsController, type: :routing do
  describe "FR routing" do
    it { expect(get: "/admin/articles").to   route_to("admin/posts#index", locale: "fr") }
    it { expect(get: "/admin/articles/1").to route_to("admin/posts#show",  locale: "fr", id: "1") }
    
    it { expect(get:  "/admin/articles/nouveau").to route_to("admin/posts#new",    locale: "fr") }
    it { expect(post: "/admin/articles").to         route_to("admin/posts#create", locale: "fr") }
    
    it { expect(get:   "/admin/articles/1/modifier").to route_to("admin/posts#edit",   locale: "fr", id: "1") }
    it { expect(put:   "/admin/articles/1").to          route_to("admin/posts#update", locale: "fr", id: "1") }
    it { expect(patch: "/admin/articles/1").to          route_to("admin/posts#update", locale: "fr", id: "1") }
    
    it { expect(delete: "/admin/articles/1").to route_to("admin/posts#destroy", locale: "fr", id: "1") }
  end
  
  describe "EN routing" do
    it { expect(get: "/admin/posts").to   route_to("admin/posts#index", locale: "en") }
    it { expect(get: "/admin/posts/1").to route_to("admin/posts#show",  locale: "en", id: "1") }
    
    it { expect(get:  "/admin/posts/new").to route_to("admin/posts#new",    locale: "en") }
    it { expect(post: "/admin/posts").to     route_to("admin/posts#create", locale: "en") }
    
    it { expect(get:   "/admin/posts/1/edit").to route_to("admin/posts#edit",   locale: "en", id: "1") }
    it { expect(put:   "/admin/posts/1").to      route_to("admin/posts#update", locale: "en", id: "1") }
    it { expect(patch: "/admin/posts/1").to      route_to("admin/posts#update", locale: "en", id: "1") }
    
    it { expect(delete: "/admin/posts/1").to route_to("admin/posts#destroy", locale: "en", id: "1") }
  end
end
