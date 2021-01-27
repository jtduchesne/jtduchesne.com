 require 'rails_helper'

RSpec.describe Admin::AboutsController, type: :request do
  before { login_as_admin }
  
  let!(:about) { FactoryBot.create(:about) }
  
  describe "GET" do
    let!(:action) { get url }
    
    describe "/admin/à-propos" do
      let(:url) { abouts_url }
      it { expect(response).to be_successful }
    end
    describe "/admin/à-propos/:id" do
      let(:url) { about_url(about) }
      it { expect(response).to be_successful }
    end
    describe "/admin/à-propos/nouveau" do
      let(:url) { new_about_url }
      it { expect(response).to be_successful }
    end
    describe "/admin/à-propos/:id/modifier" do
      let(:url) { edit_about_url(about) }
      it { expect(response).to be_successful }
    end
  end
  
  let(:valid_attributes)   { FactoryBot.attributes_for(:about) }
  let(:invalid_attributes) { FactoryBot.attributes_for(:about, fr: "") }
  
  describe "POST" do
    let(:action) { post url, params: { about: attributes } }
    
    describe "/admin/à-propos" do
      let(:url) { abouts_url }
      
      context "with valid parameters" do
        let(:attributes) { valid_attributes }
        
        it "creates a new about" do
          expect{ action }.to change(About, :count).by(1)
        end
        
        it "redirects to the created about" do
          action
          expect(response).to redirect_to(about_url(About.order(:created_at).last))
        end
      end
      
      context "with invalid parameters" do
        let(:attributes) { invalid_attributes }
        
        it "does not create a new about" do
          expect{ action }.not_to change(About, :count)
        end
        
        it "renders 'new' template" do
          action
          expect(response).to render_template(:new)
        end
      end
    end
  end
  
  describe "PATCH" do
    let(:action) { patch url, params: { about: new_attributes } }
    
    describe "/admin/à-propos/:id" do
      let(:url) { about_url(about) }
      
      context "with valid parameters" do
        let(:new_attributes) { {fr: "Changé", en: "Changed"} }
        
        it "updates the requested about" do
          expect{ action }.to change{ about.reload.fr.to_plain_text }
        end
        it "updates the requested about" do
          expect{ action }.to change{ about.reload.en.to_plain_text }
        end
        
        it "redirects to the about" do
          action
          expect(response).to redirect_to(about_url(about))
        end
      end
      
      context "with invalid parameters" do
        let(:new_attributes) { invalid_attributes }
        
        it "does not update the requested about" do
          expect{ action }.not_to change{ about.reload.fr.to_plain_text }
        end
        it "does not update the requested about" do
          expect{ action }.not_to change{ about.reload.en.to_plain_text }
        end
        
        it "renders 'edit' template" do
          action
          expect(response).to render_template(:edit)
        end
      end
    end
  end
  
  describe "DELETE" do
    let(:action) { delete url }
    
    describe "/admin/à-propos/:id" do
      let(:url) { about_url(about) }
      
      it "destroys the requested about" do
        expect{ action }.to change(About, :count).by(-1)
      end
      
      it "redirects to the abouts list" do
        action
        expect(response).to redirect_to(abouts_url)
      end
    end
  end
end
