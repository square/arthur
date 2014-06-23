
RSpec.configure do |c|
  c.before do
    Arthur::Api.configure('https://api.custombugsnaghost.com:1234', 'auth-token')
  end
end

def full_url(url, params={})
  RestClient::Request.new({:method => :get, :url => ""}).process_url_params(Arthur::Api.full_path(url), {'params' => params.merge(auth_token: Arthur::Api.auth_token)})
end
