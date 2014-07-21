require 'arthur/error'

require 'spec_helper'

describe Arthur::Error do
  before do
    stub_request(:get, full_url(path)).to_return(:body => api_response)
  end

  let(:api_response) do
    %({
      "id": "518031bcd775355c48a1cd4f",
      "class": "NoMethodError",
      "last_message": "undefined method `name' for nil:NilClass",
      "last_context": "mailer#admin",
      "resolved": false,
      "occurrences": 8,
      "users_affected": 8,
      "contexts": {
        "mailer#admin": 8
      },
      "release_stages": {
        "production": 8
      },
      "first_received": "2013-04-30T21:03:56Z",
      "last_received": "2013-07-29T10:42:05Z",
      "comments_url": "bugsnag-host/errors/518031bcd775355c48a1cd4f/comments",
      "events_url": "bugsnag-host/errors/518031bcd775355c48a1cd4f/events",
      "html_url": "https://bugsnag.com/errors/518031bcd775355c48a1cd4f",
      "url": "bugsnag-host/errors/518031bcd775355c48a1cd4f"
    })
  end

  let(:error_id) { "518031bcd775355c48a1cd4f" }

  let(:error) do
    Arthur::Error.fetch(error_id)
  end

  let(:path) { "/errors/#{error_id}"}

  describe '.fetch' do
    it "fetches the correct data from the API" do
      expect(error.data['id']).to eq(error_id)
      expect(error.data['occurrences']).to eq(8)
    end
  end

  describe '#count_in_environment' do
    context 'production environment' do
      subject do
        error.count_in_environment('production')
      end
      it { should eq(8) }
    end
    context 'staging environment' do
      subject do
        error.count_in_environment('staging')
      end
      it { should eq(0) }
    end
  end
end
