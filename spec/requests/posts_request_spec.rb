 require 'rails_helper'

RSpec.describe Admin::PostsController, type: :request do
  before { login_as_admin }
  
  let!(:post_model) { FactoryBot.create(:post) }
  
  describe "GET" do
    let!(:action) { get url }
    
    describe "/articles" do
      let(:url) { admin_posts_url }
      it { expect(response).to be_successful }
    end
    describe "/articles/:id" do
      let(:url) { admin_post_url(post_model) }
      it { expect(response).to be_successful }
    end
    describe "/articles/new" do
      let(:url) { new_admin_post_url }
      it { expect(response).to be_successful }
    end
    describe "/articles/:id/edit" do
      let(:url) { edit_admin_post_url(post_model) }
      it { expect(response).to be_successful }
    end
  end
  
  let(:valid_attributes)   { FactoryBot.attributes_for(:post) }
  let(:invalid_attributes) { FactoryBot.attributes_for(:post, title: "") }
  
  describe "POST" do
    let(:action) { post url, params: { post: attributes } }
    
    describe "/articles" do
      let(:url) { admin_posts_url }
      
      context "with valid parameters" do
        let(:attributes) { valid_attributes }
        
        it "creates a new post" do
          expect{ action }.to change(Post, :count).by(1)
        end
        
        it "redirects to the created post" do
          action
          expect(response).to redirect_to(admin_post_url(Post.order(:created_at).last))
        end
      end
      
      context "with invalid parameters" do
        let(:attributes) { invalid_attributes }
        
        it "does not create a new post" do
          expect{ action }.not_to change(Post, :count)
        end
        
        it "renders 'new' template" do
          action
          expect(response).to render_template(:new)
        end
      end
    end
  end
  
  describe "PATCH" do
    let(:action) { patch url, params: { post: new_attributes } }
    
    describe "/articles/:id" do
      let(:url) { admin_post_url(post_model) }
      
      context "with valid parameters" do
        let(:new_attributes) { {title: "Changed"} }
        
        it "updates the requested post" do
          expect{ action }.to change{ post_model.reload.title }
        end
        
        it "redirects to the post" do
          action
          expect(response).to redirect_to(admin_post_url(post_model))
        end
      end
      
      context "with invalid parameters" do
        let(:new_attributes) { invalid_attributes }
        
        it "does not update the requested post" do
          expect{ action }.not_to change{ post_model.reload.title }
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
    
    describe "/articles/:id" do
      let(:url) { admin_post_url(post_model) }
      
      it "destroys the requested post" do
        expect{ action }.to change(Post, :count).by(-1)
      end
      
      it "redirects to the posts list" do
        action
        expect(response).to redirect_to(admin_posts_url)
      end
    end
  end
end
