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
  
end
