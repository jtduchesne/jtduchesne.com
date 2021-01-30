require 'rails_helper'

RSpec.describe Admin::UsersController, type: :request do
  before { login_as_admin }
  
  let!(:user) { FactoryBot.create(:user) }
  
  describe "GET" do
    let!(:action) { get url }
    
    describe "/admin/utilisateurs" do
      let(:url) { admin_users_url }
      it { expect(response).to be_successful }
    end
    
    describe "/admin/utilisateur/:id" do
      let(:url) { admin_user_url(user) }
      it { expect(response).to be_successful }
    end
    
    describe "/admin/utilisateur/:id/modifier" do
      let(:url) { edit_admin_user_url(user) }
      it { expect(response).to be_successful }
    end
  end
  
  let(:valid_attributes)   { FactoryBot.attributes_for(:user) }
  let(:invalid_attributes) { FactoryBot.attributes_for(:user, email: "") }
  
  describe "PATCH" do
    let(:action) { patch url, params: { user: new_attributes } }
    
    describe "/admin/utilisateur/:id" do
      let(:url) { admin_user_url(user) }
      
      context "with valid parameters" do
        let(:new_attributes) { FactoryBot.attributes_for(:user) }
        
        it "updates the requested user" do
          expect{ action }.to change{ user.reload.email }
        end
        
        it "redirects to the user" do
          action
          expect(response).to redirect_to(admin_user_url(user))
        end
      end
      
      context "with invalid parameters" do
        let(:new_attributes) { invalid_attributes }
        
        it "does not update the requested user" do
          expect{ action }.not_to change{ user.reload.email }
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
    
    describe "/admin/utilisateur/:id" do
      let(:url) { admin_user_url(user) }
      
      it "destroys the requested user" do
        expect{ action }.to change(User, :count).by(-1)
      end
      
      it "redirects to the users list" do
        action
        expect(response).to redirect_to(admin_users_url)
      end
    end
  end
end
