 require 'rails_helper'

RSpec.describe Admin::ProjectsController, type: :request do
  before { login_as_admin }
  
  let!(:project) { FactoryBot.create(:project) }
  
  describe "GET" do
    let!(:action) { get url }
    
    describe "/admin/projets" do
      let(:url) { admin_projects_url }
      it { expect(response).to be_successful }
    end
    describe "/admin/projets/:id" do
      let(:url) { admin_project_url(project) }
      it { expect(response).to be_successful }
    end
    describe "/admin/projets/nouveau" do
      let(:url) { new_admin_project_url }
      it { expect(response).to be_successful }
    end
    describe "/admin/projets/:id/modifier" do
      let(:url) { edit_admin_project_url(project) }
      it { expect(response).to be_successful }
    end
  end
  
  let(:valid_attributes)   { FactoryBot.attributes_for(:project) }
  let(:invalid_attributes) { FactoryBot.attributes_for(:project, name: "") }
  
  describe "POST" do
    let(:action) { post url, params: { project: attributes } }
    
    describe "/admin/projets" do
      let(:url) { admin_projects_url }
      
      context "with valid parameters" do
        let(:attributes) { valid_attributes }
        
        it "creates a new project" do
          expect{ action }.to change(Project, :count).by(1)
        end
        
        it "redirects to the created project" do
          action
          expect(response).to redirect_to(admin_project_url(Project.order(:created_at).last))
        end
      end
      
      context "with invalid parameters" do
        let(:attributes) { invalid_attributes }
        
        it "does not create a new project" do
          expect{ action }.not_to change(Project, :count)
        end
        
        it "renders 'new' template" do
          action
          expect(response).to render_template(:new)
        end
      end
    end
  end
  
  describe "PATCH" do
    let(:action) { patch url, params: { project: new_attributes } }
    
    describe "/admin/projets/:id" do
      let(:url) { admin_project_url(project) }
      
      context "with valid parameters" do
        let(:new_attributes) { {name: "Changed"} }
        
        it "updates the requested project" do
          expect{ action }.to change{ project.reload.name }
        end
        
        it "redirects to the project" do
          action
          expect(response).to redirect_to(admin_project_url(project))
        end
      end
      
      context "with invalid parameters" do
        let(:new_attributes) { invalid_attributes }
        
        it "does not update the requested project" do
          expect{ action }.not_to change{ project.reload.name }
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
    
    describe "/admin/projets/:id" do
      let(:url) { admin_project_url(project) }
      
      it "destroys the requested project" do
        expect{ action }.to change(Project, :count).by(-1)
      end
      
      it "redirects to the projects list" do
        action
        expect(response).to redirect_to(admin_projects_url)
      end
    end
  end
end
