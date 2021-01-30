module URIHelper
  RSpec.shared_context "non-ASCII characters" do
    let(:à) { "%C3%A0" }
  end
end
