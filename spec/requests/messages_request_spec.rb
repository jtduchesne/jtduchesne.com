 require 'rails_helper'

RSpec.describe Admin::MessagesController, type: :request do
  before { login_as_admin }
  
  let!(:message) { FactoryBot.create(:message) }
  
  describe "GET" do
    let!(:action) { get url }
    
    describe "/admin/messages" do
      let(:url) { admin_messages_url }
      it { expect(response).to be_successful }
    end
    describe "/admin/messages/:id" do
      let(:url) { admin_message_url(message) }
      it { expect(response).to be_successful }
    end
    describe "/admin/messages/nouveau" do
      let(:url) { new_admin_message_url }
      it { expect(response).to be_successful }
    end
  end
  
  let(:valid_attributes)   { FactoryBot.attributes_for(:message) }
  let(:invalid_attributes) { FactoryBot.attributes_for(:message, body: "") }
  
  describe "POST" do
    let(:action) { post url, params: { message: attributes } }
    
    describe "/admin/messages" do
      let(:url) { admin_messages_url }
      
      context "with valid parameters" do
        let(:attributes) { valid_attributes }
        
        it "creates a new message" do
          expect{ action }.to change(Message, :count).by(1)
        end
        
        it "redirects to the created message" do
          action
          expect(response).to redirect_to(admin_message_url(Message.order(:created_at).last))
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
  
  describe "DELETE" do
    let(:action) { delete url }
    
    describe "/admin/messages/:id" do
      let(:url) { admin_message_url(message) }
      
      it "destroys the requested message" do
        expect{ action }.to change(Message, :count).by(-1)
      end
      
      it "redirects to the messages list" do
        action
        expect(response).to redirect_to(admin_messages_url)
      end
    end
  end
end
