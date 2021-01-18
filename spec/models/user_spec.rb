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
  
  #= Scopes =====================================================================#
  
  context do
    let!(:verified_user)   { FactoryBot.create(:user, :verified) }
    let!(:unverified_user) { FactoryBot.create(:user) }
    
    describe ".verified" do
      subject { User.verified }
      
      it { is_expected.to     include verified_user }
      it { is_expected.not_to include unverified_user }
    end
    describe ".unverified" do
      subject { User.unverified }
      
      it { is_expected.not_to include verified_user }
      it { is_expected.to     include unverified_user }
    end
  end
  
  #= Attributes =================================================================#
  
  let(:user) { FactoryBot.create(:user) }
  
  describe "#email" do
    subject { user.email }
    it { is_expected.to be_a(String) }
  end
  
  describe "#verified?" do
    subject { user.verified? }
    it { is_expected.to be false }
    
    context "if the user is verified" do
      let(:user) { FactoryBot.create(:user, :verified) }
      it { is_expected.to be true }
    end
  end
  describe "#verified_at" do
    subject { user.verified_at }
    it { is_expected.to be_nil }
    
    context "if the user is verified" do
      let(:user) { FactoryBot.create(:user, :verified) }
      it { is_expected.to be_a(Time) }
    end
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
  
  describe "#verify!(token)" do
    subject { user.verify!(token) }
    
    context "with the right token" do
      let(:token) { user.token }
      
      context "if the user is not verified" do
        let(:user) { FactoryBot.create(:user, :unverified) }
        
        it "sets #verified?" do
          expect{ subject }.to change{ user.reload.verified? }.from(false).to(true)
        end
        it "sets #verified_at" do
          expect{ subject }.to change{ user.reload.verified_at }.from(nil)
        end
        
        it "returns the user" do
          expect(subject).to be user
        end
      end
      context "if the user is already verified" do
        let(:user) { FactoryBot.create(:user, :verified) }
        
        it "does not change #verified?" do
          expect{ subject }.not_to change{ user.reload.verified? }.from(true)
        end
        it "does not change #verified_at" do
          expect{ subject }.not_to change{ user.reload.verified_at }
        end
        
        it "returns the user" do
          expect(subject).to be user
        end
      end
    end
    
    context "with the wrong token" do
      let(:token) { "wrongtoken" }
      
      it "does not set #verified?" do
        expect{ subject }.not_to change{ user.reload.verified? }.from(false)
      end
      it "does not set #verified_at" do
        expect{ subject }.not_to change{ user.reload.verified_at }.from(nil)
      end
      
      it "returns nil" do
        expect(subject).to be_nil
      end
    end
  end
  
  #= Class Methods ==============================================================#
  
  describe ".verify!(token)" do
    subject { User.verify!(token) }
    
    context "with an existing token" do
      let(:token) { user.token }
      
      it "verifies the corresponding user" do
        expect{ subject }.to change{ user.reload.verified? }.from(false).to(true)
      end
      it "returns the corresponding user" do
        expect(subject).to eq user
      end
    end
    
    context "with a wrong token" do
      let(:token) { "wrongtoken" }
      
      it "does not verify any user" do
        expect{ subject }.not_to change(User.verified, :count)
      end
      it "returns nil" do
        expect(subject).to be_nil
      end
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
