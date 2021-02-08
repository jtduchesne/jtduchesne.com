require 'rails_helper'

RSpec.describe HomeController, type: :request do

  describe 'GET' do
    before { get url }
    
    describe '/' do
      let(:url) { "/" }
      
      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end
    end
    
    describe '/fr' do
      let(:url) { "/fr" }
      
      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end
      it 'sets locale to :fr' do
        expect(I18n.locale).to eq :fr
      end
    end
    
    describe '/en' do
      let(:url) { "/en" }
      
      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end
      it 'sets locale to :en' do
        expect(I18n.locale).to eq :en
      end
    end
    
    describe "/projets" do
      let(:url) { projects_url }
      
      it "returns http success" do
        expect(response).to have_http_status(:success)
      end
    end
    describe "/projets/nom-du-projet" do
      let!(:project) { FactoryBot.create(:project) }
      
      let(:url) { project_url(project) }
      
      it "returns http success" do
        expect(response).to have_http_status(:success)
      end
    end
    
    describe "/contacter" do
      let(:url) { contact_url }
      
      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end
    end
    
    describe "/à-propos" do
      let(:url) { about_url }
      
      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe "POST" do
    let(:action) { post url, params: params }
    
    describe "/contacter" do
      let(:valid_attributes)   { FactoryBot.attributes_for(:message) }
      let(:invalid_attributes) { FactoryBot.attributes_for(:message, body: "") }
      
      let(:url)    { contact_url }
      let(:params) { { message: attributes } }
      
      context "with valid parameters" do
        let(:attributes) { valid_attributes }
        
        it "creates a new message" do
          expect{ action }.to change(Message, :count).by(1)
        end
        
        it "redirects back to the contact page" do
          action
          expect(response).to redirect_to(contact_url)
        end
        it "sets a successful flash notice" do
          action
          expect(flash.to_hash).to have_key("notice")
          expect(flash[:notice]).to include("message").and include("envoyé")
        end
      end
      
      context "with invalid parameters" do
        let(:attributes) { invalid_attributes }
        
        it "does not create a new message" do
          expect{ action }.not_to change(Message, :count)
        end
        
        it "renders 'new' template" do
          action
          expect(response).to render_template(:new)
        end
      end
    end
  end

end
