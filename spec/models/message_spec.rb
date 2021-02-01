require 'rails_helper'

RSpec.describe Message, type: :model do
  #= Validations ================================================================#
  
  it "requires a from" do
    expect(FactoryBot.build(:message, from: nil)).not_to be_valid
  end
  it "requires a subject" do
    expect(FactoryBot.build(:message, subject: nil)).not_to be_valid
  end
  it "requires a body" do
    expect(FactoryBot.build(:message, body: nil)).not_to be_valid
  end
  
  #= Scopes =====================================================================#
  
  context do
    let!(:read)   { FactoryBot.create(:message, :read) }
    let!(:unread) { FactoryBot.create(:message, :unread) }
    
    describe ".read" do
      subject { Message.read }
      
      it { is_expected.to include read }
      it { is_expected.not_to include unread }
    end
    describe ".unread" do
      subject { Message.unread }
      
      it { is_expected.not_to include read }
      it { is_expected.to include unread }
    end
  end
  
  #= Attributes =================================================================#
  
  let(:message) { FactoryBot.create(:message) }
  
  describe "#from" do
    subject { message.from }
    it { is_expected.to be_a(String) }
  end
  describe "#subject" do
    subject { message.subject }
    it { is_expected.to be_a(String) }
  end
  describe "#body" do
    subject { message.body }
    it { is_expected.to be_a(String) }
  end
  
  describe "#read?" do
    subject { message.read? }
    it { is_expected.to be false }
    
    context "when the message has been read" do
      before { message.read! }
      it { is_expected.to be true }
    end
  end
  describe "#unread?" do
    subject { message.unread? }
    it { is_expected.to be true }
    
    context "when the message has been read" do
      before { message.read! }
      it { is_expected.to be false }
    end
  end
  
  #= Instance Methods ===========================================================#
  
  describe "#read!" do
    subject { message.read! }
    
    it "sets #read?" do
      expect{ subject }.to change{ message.read? }.from(false).to(true)
    end
    it "changes #updated_at" do
      expect{ subject }.to change{ message.updated_at }
    end
    
    context "if the message had already been read" do
      before { message.read! }
      
      it "does not change #read?" do
        expect{ subject }.not_to change{ message.read? }.from(true)
      end
      it "does not change #updated_at" do
        expect{ subject }.not_to change{ message.updated_at }
      end
    end
  end
  
end
