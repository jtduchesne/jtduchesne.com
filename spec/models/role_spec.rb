require 'rails_helper'

RSpec.describe Role, type: :model do
  #= Validations ================================================================#
  
  it "requires a name" do
    expect(FactoryBot.build(:role, name: nil)).not_to be_valid
  end
  it "requires a unique name" do
    existing = FactoryBot.create(:role)
    expect(FactoryBot.build(:role, name: existing.name)).not_to be_valid
  end
  
  #= Attributes =================================================================#
  
  let(:role) { FactoryBot.build(:role) }
  
  describe "#name" do
    subject { role.name }
    it { is_expected.to be_a(String) }
  end
  
  describe "#administrator?" do
    subject { role.administrator? }
    it { is_expected.to be(false) }
  end
  
  describe "#administrator!" do
    subject { role.administrator! }
    
    it "sets #administrator?" do
      expect{ subject }.to change{ role.administrator? }.from(false).to(true)
    end
    it "cannot be used twice" do
      FactoryBot.build(:role).administrator!
      expect{ subject }.to raise_error(ActiveRecord::ActiveRecordError)
    end
  end
  
  #= Associations ===============================================================#
  
  describe "#user" do
    let(:role) { FactoryBot.create(:role).reload }
    
    subject { role.user }
    it { is_expected.to be_a(User) }
    it { is_expected.to be_readonly }
  end
end
