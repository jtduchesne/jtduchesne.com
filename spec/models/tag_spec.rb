require 'rails_helper'

RSpec.describe Tag, type: :model do
  #= Validations ================================================================#
  
  it "requires a name" do
    expect(FactoryBot.build(:tag, name: "")).not_to be_valid
  end
  it "requires a unique name" do
    existing = FactoryBot.create(:tag)
    expect(FactoryBot.build(:tag, name: existing.name)).not_to be_valid
  end
  
  #= Attributes =================================================================#
  
  let(:tag) { FactoryBot.create(:tag) }
  
  describe "#name" do
    subject { tag.name }
    it { is_expected.to be_a(String) }
  end
  
  #= Associations ===============================================================#
  
  describe "#projects" do
    let(:tag) { FactoryBot.create(:tag, :with_projects) }
    
    subject { tag.projects }
    
    it { expect(subject).to be_an(Enumerable) }
    it { expect(subject.take).to be_a(Project) }
  end
  
end
