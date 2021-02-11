require 'rails_helper'

RSpec.shared_examples "Sluggable" do
  let(:model)     { described_class.to_s.underscore.to_sym }
  let(:sluggable) { FactoryBot.create(model) }
  
  #= Validations ================================================================#
  
  it "requires a slug" do
    expect(FactoryBot.build(model, slug: "")).not_to be_valid
  end
  it "requires a unique slug" do
    existing = FactoryBot.create(model)
    expect(FactoryBot.build(model, slug: existing.slug)).not_to be_valid
  end
  it "requires a slug without spaces or slashes" do
    expect(FactoryBot.build(model, slug: "te st")).not_to be_valid
    expect(FactoryBot.build(model, slug: "te/st")).not_to be_valid
    expect(FactoryBot.build(model, slug: "te\\st")).not_to be_valid
  end
  
  #= Attributes =================================================================#
  
  describe "#slug" do
    subject { sluggable.slug }
    it { is_expected.to be_a(String) }
  end
  
  #= Instance methods ===========================================================#
  
  describe "#to_param" do
    subject { sluggable.to_param }
    it { is_expected.not_to be_a(Numeric) }
    it { is_expected.to be_a(String) }
    it { is_expected.to eq sluggable.slug }
  end
  
  #= Class methods ==============================================================#
  
  describe ".find(id)" do
    let!(:sluggable) { FactoryBot.create(model) }
    
    it "can find the model with its slug" do
      expect(described_class.find(sluggable.slug)).to eq sluggable
    end
    it "can find the model with its id" do
      expect(described_class.find(sluggable.id)).to eq sluggable
    end
    it "raises an exception if neither are found" do
      expect{ described_class.find("bad-slug") }.to raise_error(ActiveRecord::RecordNotFound)
      expect{ described_class.find(1234567890) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
  
end
