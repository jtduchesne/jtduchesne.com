require 'rails_helper'

RSpec.describe "Home", type: :request do

  describe 'GET' do
    before { get url }
    
    describe '/' do
      let(:url) { "/" }
      
      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end
    end
    
    describe '/fr' do
      let(:url) { "/fr" }
      
      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end
      it 'sets locale to :fr' do
        expect(I18n.locale).to eq :fr
      end
    end
    
    describe '/en' do
      let(:url) { "/en" }
      
      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end
      it 'sets locale to :en' do
        expect(I18n.locale).to eq :en
      end
    end
  end

end
