# RSpec.describe PumaCloudwatch::Metrics::Fetcher do
#   subject(:fetcher) { described_class.new(control_url: '', control_auth_token: '') }

#   describe "fetcher" do
#     it "call" do
#       fake_data = {"fake" => "data"}
#       json_data = JSON.dump(fake_data)
#       allow(Socket).to receive(:unix).and_return(json_data)

#       stats = fetcher.call
#       expect(stats).to eq(fake_data)
#     end
#   end
# end


RSpec.describe PumaCloudwatch::Metrics::Fetcher do
  subject(:fetcher) { described_class.new(control_url: 'unix:///tmp/fake.sock', control_auth_token: '') }

  describe "fetcher" do
    it "calls and parses the socket response" do
      fake_data = { "fake" => "data" }
      response_body = "HTTP/1.0 200 OK\r\n\r\n#{JSON.dump(fake_data)}"

      mock_socket = double("socket")
      allow(mock_socket).to receive(:print)
      allow(mock_socket).to receive(:read).and_return(response_body)

      allow(Socket).to receive(:unix).and_yield(mock_socket)

      stats = fetcher.call
      expect(stats).to eq(fake_data)
    end
  end
end
