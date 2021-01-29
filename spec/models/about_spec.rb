require 'rails_helper'

RSpec.describe About, type: :model do
  #= Validations ================================================================#
  
  it "requires FR content" do
    expect(FactoryBot.build(:about, fr: nil)).not_to be_valid
  end
  it "requires EN content" do
    expect(FactoryBot.build(:about, en: nil)).not_to be_valid
  end
  
  #= Scopes =====================================================================#
  
  context do
    let!(:draft)   { FactoryBot.create(:about, :draft) }
    let!(:current) { FactoryBot.create(:about, published_on: Date.yesterday) }
    let!(:past)    { FactoryBot.create(:about, published_on: 1.week.ago) }
    
    describe ".draft" do
      subject { About.draft }
      
      it { is_expected.to include draft }
      it { is_expected.not_to include current }
      it { is_expected.not_to include past }
    end
    describe ".published" do
      subject { About.published }
      
      it { is_expected.not_to include draft }
      it { is_expected.to include current }
      it { is_expected.to include past }
    end
    
    describe ".current" do
      subject { About.current }
      
      it { is_expected.to eq current }
    end
  end
  
  #= Attributes =================================================================#
  
  let(:about) { FactoryBot.create(:about) }
  
  describe "#fr" do
    subject { about.fr }
    it { is_expected.to be_a(ActionText::RichText) }
  end
  describe "#en" do
    subject { about.en }
    it { is_expected.to be_a(ActionText::RichText) }
  end
  
  describe "#from" do
    subject { about.from }
    
    context "when not published" do
      it { is_expected.to be_nil }
    end
    context "when published" do
      let(:about) { FactoryBot.create(:about, published_on: Date.yesterday) }
      it { is_expected.to be_a(Date) }
      it { is_expected.to eq about.published_on }
    end
  end
  describe "#to" do
    let!(:past) { FactoryBot.create(:about, published_on: Date.yesterday) }
    
    subject { about.to }
    
    context "when not published" do
      it { is_expected.to be_nil }
    end
    context "when just published" do
      let(:about) { FactoryBot.create(:about, :published) }
      it { is_expected.to be_nil }
    end
    context "when published and a newer one exists" do
      let!(:newer) { FactoryBot.create(:about, published_on: Date.yesterday) }
      
      let(:about) { FactoryBot.create(:about, published_on: 1.week.ago) }
      it { is_expected.to be_a(Date) }
      it { is_expected.to eq newer.published_on }
    end
  end
  
  describe "#published" do
    subject { about.published }
    it { is_expected.to be false }
    
    context "when published" do
      let(:about) { FactoryBot.create(:about, :published) }
      it { is_expected.to be true }
    end
  end
  
  describe "#published=(value)" do
    subject { about.published = value }
    
    context "when value is true" do
      let(:value) { true }
      
      it "clears #draft?" do
        expect{ subject }.to change{ about.draft? }.from(true).to(false)
      end
      it "sets #published?" do
        expect{ subject }.to change{ about.published? }.from(false).to(true)
      end
      it "sets #published_on to today" do
        expect{ subject }.to change{ about.published_on }.to(Date.today)
      end
    end
    context "when value is false" do
      let(:value) { false }
      
      it "does not clear #draft?" do
        expect{ subject }.not_to change{ about.draft? }.from(true)
      end
      it "does not set #published?" do
        expect{ subject }.not_to change{ about.published? }.from(false)
      end
      it "does not change #published_on" do
        expect{ subject }.not_to change{ about.published_on }.from(nil)
      end
      
      it "cannot un-publish" do
        about.published_on = 1.week.ago
        expect{ subject }.not_to change{ about.published_on }.from(1.week.ago.to_date)
        expect(about.published).to be true
      end
    end
  end
  
  describe "#published?" do
    subject { about.published? }
    it { is_expected.to be false }
    
    context "when published" do
      let(:about) { FactoryBot.create(:about, :published) }
      it { is_expected.to be true }
    end
  end
  
  describe "#draft?" do
    subject { about.draft? }
    it { is_expected.to be true }
    
    context "when published" do
      let(:about) { FactoryBot.create(:about, :published) }
      it { is_expected.to be false }
    end
  end
  
  describe "#current?" do
    let!(:past) { FactoryBot.create(:about, published_on: Date.yesterday) }
    
    subject { about.current? }
    
    context "when not published" do
      it { is_expected.to be false }
    end
    context "when published but a newer one exists" do
      let(:about) { FactoryBot.create(:about, published_on: 1.week.ago) }
      it { is_expected.to be false }
    end
    context "when just published" do
      let(:about) { FactoryBot.create(:about, :published) }
      it { is_expected.to be true }
    end
  end
  
  describe "#past?" do
    let!(:past) { FactoryBot.create(:about, published_on: Date.yesterday) }
    
    subject { about.past? }
    
    context "when not published" do
      it { is_expected.to be false }
    end
    context "when published but a newer one exists" do
      let(:about) { FactoryBot.create(:about, published_on: 1.week.ago) }
      it { is_expected.to be true }
    end
    context "when just published" do
      let(:about) { FactoryBot.create(:about, :published) }
      it { is_expected.to be false }
    end
  end
end
