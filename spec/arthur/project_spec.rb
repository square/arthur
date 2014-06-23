require './lib/arthur/project.rb'
require './lib/arthur/error.rb'
require 'webmock/rspec'


describe Arthur::Project do
  describe '.list' do
    let(:path) do
      '/account/projects'
    end
    let(:api_response) do
      '[
        {
          "id": "50baed119bf39c1431000004",
          "name": "Website",
          "api_key": "a0f5e56c125d2eeac31fd66e4f0cbd79",
          "errors": 78,
          "icon": "https://bugsnag.com/assets/frameworks/rails.png",
          "release_stages": ["production", "development"],
          "type": "rails",
          "created_at": "2012-12-02T05:54:25Z",
          "updated_at": "2013-06-17T19:57:49Z",
          "errors_url": "bugsnag-host/projects/50baed119bf39c1431000004/errors",
          "events_url": "bugsnag-host/projects/50baed119bf39c1431000004/events",
          "html_url": "https://bugsnag.com/dashboard/website",
          "url": "bugsnag-host/projects/50baed119bf39c1431000004"
        },
        {
          "id": "50baed119bf39c1431000007",
          "name": "Another Website",
          "api_key": "a0f5e56c125d2eeac31fd66e4f0cbd79",
          "errors": 25,
          "icon": "https://bugsnag.com/assets/frameworks/rails.png",
          "release_stages": ["production", "development"],
          "type": "rails",
          "created_at": "2012-12-02T05:54:25Z",
          "updated_at": "2013-06-17T19:57:49Z",
          "errors_url": "bugsnag-host/projects/50baed119bf39c1431000004/errors",
          "events_url": "bugsnag-host/projects/50baed119bf39c1431000004/events",
          "html_url": "https://bugsnag.com/dashboard/website",
          "url": "bugsnag-host/projects/50baed119bf39c1431000004"
        }
      ]'
    end

    it "returns the correct list" do
      # stub_api_response(api_response)
      stub_request(:get, full_url(path)).to_return(:body => api_response)
      responses = Arthur::Project.list
      expect(responses.first.data['id']).to eq("50baed119bf39c1431000004")
      expect(responses.first.data['name']).to eq("Website")
      expect(responses.last.data['id']).to eq("50baed119bf39c1431000007")
      expect(responses.last.data['name']).to eq("Another Website")
    end
  end


  describe '.fetch' do
    let(:project_id) { "50baed119bf39c1431000004" }
    let(:path) { "/projects/#{project_id}" }

    let(:api_response) do
      '{
        "id": "50baed119bf39c1431000004",
        "name": "Website",
        "api_key": "a0f5e56c125d2eeac31fd66e4f0cbd79",
        "errors": 78,
        "icon": "https://bugsnag.com/assets/frameworks/rails.png",
        "release_stages": ["production", "development"],
        "type": "rails",
        "created_at": "2012-12-02T05:54:25Z",
        "updated_at": "2013-06-17T19:57:49Z",
        "errors_url": "bugsnag-host/projects/50baed119bf39c1431000004/errors",
        "events_url": "bugsnag-host/projects/50baed119bf39c1431000004/events",
        "html_url": "https://bugsnag.com/dashboard/website",
        "url": "bugsnag-host/projects/50baed119bf39c1431000004"
      }'
    end

    it "returns the correct project" do
      stub_request(:get, full_url(path)).to_return(:body => api_response)
      response = Arthur::Project.fetch(project_id)
      expect(response.data['id']).to eq(project_id)
      expect(response.data['name']).to eq("Website")
    end
  end

  context '#errors' do
    let(:path) { "/projects/#{example_project.data['id']}/errors" }
    let(:example_project) do
      Arthur::Project.new(
        "id" => "50baed119bf39c1431000004",
        "name" => "Website",
        "api_key" => "a0f5e56c125d2eeac31fd66e4f0cbd79",
        "errors" => 78,
        "icon" => "https://bugsnag.com/assets/frameworks/rails.png",
        "release_stages" => ["production", "development"],
        "type" => "rails",
        "created_at" => "2012-12-02T05:54:25Z",
        "updated_at" => "2013-06-17T19:57:49Z",
        "errors_url" => "bugsnag-host/projects/50baed119bf39c1431000004/errors",
        "events_url" => "bugsnag-host/projects/50baed119bf39c1431000004/events",
        "html_url" => "https://bugsnag.com/dashboard/website",
        "url" => "bugsnag-host/projects/50baed119bf39c1431000004"
      )
    end

    let(:api_response) do
      %([
        {
          "id": "518031bcd775355c48a1cd4e",
          "class": "NoMethodError",
          "last_message": "undefined method `name' for nil:NilClass",
          "last_context": "mailer#admin",
          "resolved": false,
          "occurrences": 12,
          "users_affected": 13,
          "contexts": {
            "mailer#admin": 12
          },
          "release_stages": {
            "production": 12
          },
          "first_received": "2013-04-30T21:03:56Z",
          "last_received": "2013-07-29T10:42:05Z",
          "comments_url": "bugsnag-host/errors/518031bcd775355c48a1cd4e/comments",
          "events_url": "bugsnag-host/errors/518031bcd775355c48a1cd4e/events",
          "html_url": "https://bugsnag.com/errors/518031bcd775355c48a1cd4e",
          "url": "bugsnag-host/errors/518031bcd775355c48a1cd4e"
        },
        {
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
        }
      ])
    end

    it "returns the correct list" do
      stub_request(:get, full_url(path)).to_return(:body => api_response)
      responses = example_project.bugsnag_errors
      expect(responses.first.data['id']).to eq("518031bcd775355c48a1cd4e")
      expect(responses.last.data['id']).to  eq("518031bcd775355c48a1cd4f")
    end

    context "with a longer list of errors" do
      let(:first_api_response) do
        Array.new(30){ {} }.to_json
      end
      let(:second_api_response) do
        Array.new(20){ {'second' => true} }.to_json
      end
      let(:offset) { "herpderpderp" }
      it "returns the correct list" do
        stub_request(:get, full_url(path)).to_return(:body => first_api_response, :headers => {:link => "<http://localhost/projects/537ab6c3f697833600000001/errors?direction=desc&offset=#{offset}&per_page=30&sort=last_received>; rel=\"next\""})
        stub_request(:get, full_url(path, offset: offset)).to_return(:body => second_api_response)
        responses = example_project.bugsnag_errors
        expect(responses.length).to eq(50)
      end
    end
  end
end
