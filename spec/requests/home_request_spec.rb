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
  end

end
