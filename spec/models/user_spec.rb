require 'rails_helper'

RSpec.describe User, type: :model do
  #= Validations ================================================================#
  
  it "requires an email" do
    expect(FactoryBot.build(:user, email: nil)).not_to be_valid
  end
  it "requires a valid email" do
    expect(FactoryBot.build(:user, email: "<b>invalid</b>@email.com")).not_to be_valid
  end
  it "requires a unique email" do
    existing = FactoryBot.create(:user)
    expect(FactoryBot.build(:user, email: existing.email)).not_to be_valid
  end
  
  #= Attributes =================================================================#
  
  let(:user) { FactoryBot.build(:user) }
  
  describe "#email" do
    subject { user.email }
    it { is_expected.to be_a(String) }
  end
  
  describe "#admin?" do
    subject { user.admin? }
    it { is_expected.to be false }
    
    context "if the user is the administrator" do
      let(:user) { FactoryBot.create(:user, :administrator) }
      it { is_expected.to be true }
    end
  end
  
  #= Behaviors ==================================================================#
  
  context "when the user is the administrator" do
    let(:user) { FactoryBot.create(:user, :administrator) }
    
    it "cannot be updated" do
      expect{ user.update!(email: "new@email.com") }.to raise_error(ActiveRecord::ReadOnlyRecord)
    end
    it "cannot be destroyed" do
      expect{ user.destroy }.to raise_error(ActiveRecord::ReadOnlyRecord)
    end
  end
  
  #= Instance Methods ===========================================================#
  
  describe "#make_admin!" do
    let(:user) { FactoryBot.create(:user) }
    
    it "cannot be called directly" do
      expect{ user.make_admin! }.to raise_error(NoMethodError)
    end
    
    subject { user.send :make_admin! }
    
    it "promotes user to administrator" do
      expect{ subject }.to change{ user.admin? }.from(false).to(true)
    end
    
    it "cannot be used if there is already an administrator" do
      admin = FactoryBot.create(:user, :administrator)
      expect{ subject }.to raise_error(ActiveRecord::ActiveRecordError)
      expect(user.admin?).to be false
      expect(admin.admin?).to be true
    end
  end
  
  #= Associations ===============================================================#
  
  describe "#role" do
    subject { user.role }
    
    context "when the user has no role" do
      let(:user) { FactoryBot.create(:user).reload }
      
      it { is_expected.to be_nil }
    end
    context "when the user is the administrator" do
      let(:user) { FactoryBot.create(:user, :administrator).reload }
      
      it { is_expected.to be_a(Role) }
      it { is_expected.to be_readonly }
    end
  end
end
