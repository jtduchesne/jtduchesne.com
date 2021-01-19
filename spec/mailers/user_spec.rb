require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  let(:user) { FactoryBot.create(:user) }
  
  describe '.verification' do
    let(:mail) { UserMailer.with(user: user).verification }
    
    describe '#subject' do
      subject { mail.subject.downcase }
      
      context 'when in english' do
        before(:each) { I18n.locale = :en }
        it { is_expected.to include "please" }
        it { is_expected.to include "confirm" }
      end
      context 'when in french' do
        before(:each) { I18n.locale = :fr }
        it { is_expected.to include "s'il vous plait" }
        it { is_expected.to include "confirmer" }
      end
    end
    describe '#to' do
      subject { mail[:to].decoded }
      
      it { is_expected.to eq user.email }
    end
    
    describe '#body' do
      subject { mail.body.encoded }
      
      context 'when in english' do
        before(:each) { I18n.locale = :en }
        it 'contains the appropriate authentication link' do
          expect(subject).to include en_verification_url(token: user.token)
        end
      end
      context 'when in french' do
        before(:each) { I18n.locale = :fr }
        it 'contains the appropriate authentication link' do
          expect(subject).to include fr_verification_url(token: user.token)
        end
      end
    end
  end
end
