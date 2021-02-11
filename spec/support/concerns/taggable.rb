require 'rails_helper'

RSpec.shared_examples "Taggable" do
  let(:model)    { described_class.to_s.underscore.to_sym }
  let(:taggable) { FactoryBot.create(model) }
  
  #= Attributes =================================================================#
  
  describe "#tag_names" do
    subject { taggable.tag_names }
    it { is_expected.to be_a(String) }
    
    context "if there are no tags" do
      it { is_expected.to be_empty }
    end
    context "if there are tags" do
      let(:taggable) { FactoryBot.create(model, :with_tags) }
      it { is_expected.to eq taggable.tags.map(&:name).join(",") }
    end
  end
  
  describe "#tag_names=(value)" do
    let!(:existing) { FactoryBot.create(:tag) }
    
    subject { taggable.tag_names = value }
    
    context "when value is empty" do
      let!(:taggable) { FactoryBot.create(model, :with_tags) }
      let(:value) { "" }
      
      it "removes current tags" do
        expect{ subject }.to change{ taggable.tags.count }.by(a_value < 0)
      end
      it "does not destroy the tags" do
        expect{ subject }.not_to change(Tag, :count)
      end
    end
    context "when value already exists" do
      let(:value) { existing.name }
      
      it "adds the tag to the project" do
        expect{ subject }.to change{ taggable.tags.count }.by(1)
      end
      it "does not create a new tag" do
        expect{ subject }.not_to change(Tag, :count)
      end
    end
    context "when value does not exist" do
      let(:value) { "Non-existant" }
      
      it "adds the tag to the project" do
        expect{ subject }.to change{ taggable.tags.count }.by(1)
      end
      it "does create a new tag" do
        expect{ subject }.to change(Tag, :count).by(1)
      end
    end
  end
  
  describe "#hash_tags" do
    subject { taggable.hash_tags }
    it { is_expected.to be_a(String) }
    
    context "if there are no tags" do
      it { is_expected.to be_empty }
    end
    context "if there are tags" do
      let(:taggable) { FactoryBot.create(model, :with_tags) }
      it { is_expected.to eq "#"+taggable.tags.map(&:name).join(", #") }
    end
  end
end
