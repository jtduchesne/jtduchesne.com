require 'rails_helper'

RSpec.describe Project, type: :model do
  #= Validations ================================================================#
  
  it "requires a name" do
    expect(FactoryBot.build(:project, name: "")).not_to be_valid
  end
  
  it "requires a french description" do
    expect(FactoryBot.build(:project, description_fr: "")).not_to be_valid
  end
  it "requires an english description" do
    expect(FactoryBot.build(:project, description_en: "")).not_to be_valid
  end
  
  it "requires either a Live URL, a Github URL, or both" do
    expect(FactoryBot.build(:project, live_url: "", github_url: "")).not_to be_valid
    expect(FactoryBot.build(:project, live_url: "")).to be_valid
    expect(FactoryBot.build(:project, github_url: "")).to be_valid
  end
  
  it "requires a slug" do
    expect(FactoryBot.build(:project, slug: "")).not_to be_valid
  end
  it "requires a unique slug" do
    existing = FactoryBot.create(:project)
    expect(FactoryBot.build(:project, slug: existing.slug)).not_to be_valid
  end
  it "requires a slug without spaces or slashes" do
    expect(FactoryBot.build(:project, slug: "te st")).not_to be_valid
    expect(FactoryBot.build(:project, slug: "te/st")).not_to be_valid
    expect(FactoryBot.build(:project, slug: "te\\st")).not_to be_valid
  end
  
  #= Attributes =================================================================#
  
  let(:project) { FactoryBot.create(:project) }
  
  describe "#name" do
    subject { project.name }
    it { is_expected.to be_a(String) }
  end
  
  describe "#description" do
    subject { project.description }
    it { is_expected.to be_a(HashWithIndifferentAccess) }
    
    describe "[:fr]" do
      subject { project.description[:fr] }
      it { is_expected.to be_a(String) }
    end
    describe "[:en]" do
      subject { project.description[:en] }
      it { is_expected.to be_a(String) }
    end
  end
  
  describe "#tag_names" do
    subject { project.tag_names }
    it { is_expected.to be_a(String) }
    
    context "if there are no tags" do
      it { is_expected.to be_empty }
    end
    context "if there are tags" do
      let(:project) { FactoryBot.create(:project, :with_tags) }
      it { is_expected.to eq project.tags.map(&:name).join(",") }
    end
  end
  describe "#tag_names=(value)" do
    let!(:existing) { FactoryBot.create(:tag) }
    
    subject { project.tag_names = value }
    
    context "when value is empty" do
      let!(:project) { FactoryBot.create(:project, :with_tags) }
      let(:value) { "" }
      
      it "removes current tags" do
        expect{ subject }.to change{ project.tags.count }.by(a_value < 0)
      end
      it "does not destroy the tags" do
        expect{ subject }.not_to change(Tag, :count)
      end
    end
    context "when value already exists" do
      let(:value) { existing.name }
      
      it "adds the tag to the project" do
        expect{ subject }.to change{ project.tags.count }.by(1)
      end
      it "does not create a new tag" do
        expect{ subject }.not_to change(Tag, :count)
      end
    end
    context "when value does not exist" do
      let(:value) { "Non-existant" }
      
      it "adds the tag to the project" do
        expect{ subject }.to change{ project.tags.count }.by(1)
      end
      it "does create a new tag" do
        expect{ subject }.to change(Tag, :count).by(1)
      end
    end
  end
  
  describe "#live_url" do
    subject { project.live_url }
    it { is_expected.to be_a(String) }
  end
  describe "#github_url" do
    subject { project.github_url }
    it { is_expected.to be_a(String) }
  end
  
  describe "#slug" do
    subject { project.slug }
    it { is_expected.to be_a(String) }
  end
  
  #= Associations ===============================================================#
  
  describe "#tags" do
    let(:project) { FactoryBot.create(:project, :with_tag) }
    
    subject { project.tags }
    
    it { expect(subject).to be_an(Enumerable) }
    it { expect(subject.take).to be_a(Tag) }
  end
  
end
