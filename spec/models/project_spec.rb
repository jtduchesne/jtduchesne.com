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
  
  #= Attributes =================================================================#
  
  let(:project) { FactoryBot.create(:project) }
  
  it_behaves_like "Taggable"
  it_behaves_like "Sluggable"
  
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
  
  describe "#live_url" do
    subject { project.live_url }
    it { is_expected.to be_a(String) }
  end
  describe "#github_url" do
    subject { project.github_url }
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
