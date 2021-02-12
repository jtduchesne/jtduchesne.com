require 'rails_helper'

RSpec.describe Post, type: :model do
  #= Validations ================================================================#
  
  it "requires a title" do
    expect(FactoryBot.build(:post, title: "")).not_to be_valid
  end
  it "requires a preview" do
    expect(FactoryBot.build(:post, preview: "")).not_to be_valid
  end
  
  it "requires a content" do
    expect(FactoryBot.build(:post, content: "")).not_to be_valid
  end
  
  #= Scopes =====================================================================#
  
  context do
    let!(:untranslated) { FactoryBot.create(:post) }
    let!(:translated)   { FactoryBot.create(:post, :translated) }
    
    describe ".untranslated" do
      subject { Post.untranslated }
      
      it { is_expected.to include untranslated }
      it { is_expected.not_to include translated }
      it { is_expected.not_to include translated.translated }
    end
  end
  
  context do
    let!(:draft)  { FactoryBot.create(:post) }
    let!(:past)   { FactoryBot.create(:post, :already_published) }
    let!(:today)  { FactoryBot.create(:post, :published) }
    let!(:future) { FactoryBot.create(:post, :to_be_published) }
    
    describe ".draft" do
      subject { Post.draft }
      
      it { is_expected.to include draft }
      it { is_expected.not_to include past }
      it { is_expected.not_to include today }
      it { is_expected.not_to include future }
    end
    
    describe ".published" do
      subject { Post.published }
      
      it { is_expected.not_to include draft }
      it { is_expected.to include past }
      it { is_expected.to include today }
      it { is_expected.not_to include future }
    end
  end
  
  context do
    let!(:french)  { FactoryBot.create(:post, :french) }
    let!(:english) { FactoryBot.create(:post, :english) }
    
    describe ".french" do
      subject { Post.french }
      
      it { is_expected.to     include french }
      it { is_expected.not_to include english }
    end
    describe ".english" do
      subject { Post.english }
      
      it { is_expected.not_to include french }
      it { is_expected.to     include english }
    end
  end
    
  #= Attributes =================================================================#
  
  let(:post) { FactoryBot.build(:post) }
  
  it_behaves_like "Taggable"
  it_behaves_like "Sluggable"
  
  describe "#language" do
    subject { post.language }
    it { is_expected.to be_a(String) }
    
    it "defaults to french" do
      expect(subject).to eq "french"
    end
  end
  
  describe "#title" do
    subject { post.title }
    it { is_expected.to be_a(String) }
  end
  
  describe "#preview" do
    subject { post.preview }
    it { is_expected.to be_a(String) }
  end
  
  describe "#content" do
    subject { post.content }
    it { is_expected.to be_a(ActionText::RichText) }
  end
  
  describe "#published_on" do
    subject { post.published_on }
    it { is_expected.to be_nil }
    
    context "when published" do
      let(:post) { FactoryBot.build(:post, :published) }
      it { is_expected.to be_a(Date) }
    end
  end
  
  describe "#draft?" do
    subject { post.draft? }
    it { is_expected.to be true }
    
    context "when published" do
      let(:post) { FactoryBot.build(:post, :published) }
      it { is_expected.to be false }
    end
  end
  describe "#published?" do
    subject { post.published? }
    it { is_expected.to be false }
    
    context "when published" do
      let(:post) { FactoryBot.build(:post, :published) }
      it { is_expected.to be true }
    end
  end
  
  #= Associations ===============================================================#
  
  describe "#translated" do
    let(:post) { FactoryBot.create(:post, :translated) }
    
    subject { post.translated }
    
    it { expect(subject).to be_a(Post) }
    it { expect(subject.translated).to be_a(Post) }
    it { expect(subject.translated).to eq post }
  end
end
