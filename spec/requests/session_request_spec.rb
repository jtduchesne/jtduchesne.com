require 'rails_helper'

RSpec.describe "Session", type: :request do

  describe "GET" do
    let!(:action) { get url }
    
    describe "/connexion" do
      let(:url) { login_url }
      
      it "returns http success" do
        expect(response).to be_successful
      end
    end
    
    describe "/déconnexion" do
      before { login }
      
      let(:url) { logout_url }
      
      it "logs the user out" do
        expect(logged_out?).to be true
      end
      it "redirects to the homepage" do
        expect(response).to redirect_to(root_url)
      end
    end
  end

  describe "POST" do
    let!(:existing_user) { FactoryBot.create(:user) }
    let!(:new_user)      { FactoryBot.build(:user) }
    
    let(:action) { post url, params: { user: { email: email } } }
    
    describe "/connexion" do
      let(:url) { login_url }
      
      context "with a new email address" do
        let(:email) { new_user.email }
        
        it "creates a new User" do
          expect{ action }.to change(User, :count).by(1)
        end
        it "logs the user in" do
          expect{ action }.to change{ logged_in? }.to true
          expect(current_user).to have_attributes(email: new_user.email)
        end
        
        it "redirects to the homepage" do
          action
          expect(response).to redirect_to(root_url)
        end
      end
      
      context "with an existing email address" do
        let(:email) { existing_user.email }
        
        it "does not create a new User" do
          expect{ action }.not_to change(User, :count)
        end
        it "logs the user in" do
          expect{ action }.to change{ logged_in? }.to true
          expect(current_user).to eq existing_user
        end
        
        it "redirects to the homepage" do
          action
          expect(response).to redirect_to(root_url)
        end
      end
      
      context "with invalid parameters" do
        let(:email) { "inv@lid@email.com" }
        
        it "does not create a new User" do
          expect{ action }.not_to change(User, :count)
        end
        it "does not log the user in" do
          expect{ action }.to change{ logged_in? }.to false
        end
        
        it "renders a successful response (to display the 'new' template)" do
          action
          expect(response).to be_successful
        end
      end
    end
  end

  describe "DELETE" do
    before { login }
    
    let(:action) { delete url }
    
    describe "/connexion" do
      let(:url) { login_url }
      
      it "logs the user out" do
        expect{ action }.to change{ logged_out? }.to true
      end
      it "redirects to the homepage" do
        action
        expect(response).to redirect_to(root_url)
      end
    end
  end

end
