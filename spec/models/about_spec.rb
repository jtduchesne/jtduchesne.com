require 'rails_helper'

RSpec.describe About, type: :model do
  #= Validations ================================================================#
  
  it "requires FR content" do
    expect(FactoryBot.build(:about, fr: nil)).not_to be_valid
  end
  it "requires EN content" do
    expect(FactoryBot.build(:about, en: nil)).not_to be_valid
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
end
