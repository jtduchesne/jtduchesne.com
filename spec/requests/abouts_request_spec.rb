 require 'rails_helper'

RSpec.describe Admin::AboutsController, type: :request do
  before { login_as_admin }
  
  # About. As you add validations to About, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  describe "GET /index" do
    it "renders a successful response" do
      About.create! valid_attributes
      get abouts_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      about = About.create! valid_attributes
      get about_url(about)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_about_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "render a successful response" do
      about = About.create! valid_attributes
      get edit_about_url(about)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new About" do
        expect {
          post abouts_url, params: { about: valid_attributes }
        }.to change(About, :count).by(1)
      end

      it "redirects to the created about" do
        post abouts_url, params: { about: valid_attributes }
        expect(response).to redirect_to(about_url(About.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new About" do
        expect {
          post abouts_url, params: { about: invalid_attributes }
        }.to change(About, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post abouts_url, params: { about: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested about" do
        about = About.create! valid_attributes
        patch about_url(about), params: { about: new_attributes }
        about.reload
        skip("Add assertions for updated state")
      end

      it "redirects to the about" do
        about = About.create! valid_attributes
        patch about_url(about), params: { about: new_attributes }
        about.reload
        expect(response).to redirect_to(about_url(about))
      end
    end

    context "with invalid parameters" do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        about = About.create! valid_attributes
        patch about_url(about), params: { about: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested about" do
      about = About.create! valid_attributes
      expect {
        delete about_url(about)
      }.to change(About, :count).by(-1)
    end

    it "redirects to the abouts list" do
      about = About.create! valid_attributes
      delete about_url(about)
      expect(response).to redirect_to(abouts_url)
    end
  end
end
