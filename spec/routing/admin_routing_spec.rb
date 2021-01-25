require 'rails_helper'

RSpec.describe Admin::AdminController, type: :routing do
  describe "routing" do
    it { expect(get: '/admin').to    route_to("admin/admin#index") }
    it { expect(get: '/admin/fr').to route_to("admin/admin#index", locale: "fr") }
    it { expect(get: '/admin/en').to route_to("admin/admin#index", locale: "en") }
  end
end
