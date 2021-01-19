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
    let!(:verified_user) { FactoryBot.create(:user, :verified) }
    let!(:existing_user) { FactoryBot.create(:user) }
    let!(:new_user)      { FactoryBot.build(:user) }
    
    let(:action) { post url, params: { user: { email: email } } }
    
    describe "/connexion" do
      let(:url) { login_url }
      
      context "with an existing and verified email address" do
        let(:email) { verified_user.email }
        
        it "logs the user in" do
          expect{ action }.to change{ logged_in? }.to true
          expect(current_user).to eq verified_user
        end
        
        it "redirects to the homepage" do
          action
          expect(response).to redirect_to(root_url)
        end
      end
      
      context "with an existing but unverified email address" do
        let(:email) { existing_user.email }
        
        it "does not log the user in" do
          expect{ action }.to change{ logged_in? }.to false
        end
        
        it "redirects to the homepage" do
          action
          expect(response).to redirect_to(root_url)
        end
        it "sets a flash alert" do
          action
          expect(flash.to_hash).to have_key('alert')
          expect(flash.alert).to include email
        end
      end
      
      context "with a new email address" do
        let(:email) { new_user.email }
        
        it "creates a new User" do
          expect{ action }.to change(User, :count).by(1)
        end
        it "does not log the user in" do
          expect{ action }.to change{ logged_in? }.to false
        end
        
        it "sends verification email" do
          expect{ action }.to have_enqueued_mail(UserMailer, :verification)
        end
        
        it "redirects to the homepage" do
          action
          expect(response).to redirect_to(root_url)
        end
        it "sets a flash notice" do
          action
          expect(flash.to_hash).to have_key('notice')
          expect(flash.notice).to include email
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

  describe "GET /:token" do
    let!(:user) { FactoryBot.create(:user) }
    
    let(:action) { get verification_url(token) }
    
    context "with a valid token" do
      let(:token) { user.token }
      
      it "verifies the user" do
        expect{ action }.to change(User.verified, :count).by(1)
      end
      
      it "does not log the user in" do
        expect{ action }.to change{ logged_in? }.to false
      end
      
      it "redirects to the login page" do
        action
        expect(response).to redirect_to(login_url)
      end
      it "sets a flash notice" do
        action
        expect(flash.to_hash).to have_key('notice')
      end
    end
    context "with an invalid token" do
      let(:token) { "ABCDEFGHJKLMNPQRSTUVWXYZ" }
      
      it "does not verify the user" do
        expect{ action }.not_to change(User.verified, :count)
      end
      
      it "does not log a user in" do
        expect{ action }.to change{ logged_in? }.to false
      end
      
      it "redirects to the login page" do
        action
        expect(response).to redirect_to(login_url)
      end
      it "sets a flash alert" do
        action
        expect(flash.to_hash).to have_key('alert')
      end
    end
  end
end
