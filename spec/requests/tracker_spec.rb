require 'spec_helper'

describe 'tracking' do
  let(:user) { create(:user) }

  before { ActionMailer::Base.deliveries.clear }

  it "returns a tracker HTML snippet and requesting it sends an email" do
    post '/tracker', {
      recipient: 'email@example.com',
      subject: 'Hello',
      api_key: user.api_key
    }

    expect(response.body).to match('<img src="http://example.com/tracker/')
    expect(response.body).to match('tracker.gif">')

    uuid = Tracker.last.message_token
    get "http://example.com/tracker/#{uuid}/tracker.gif"
    expect(response.status).to eq 200

    email = ActionMailer::Base.deliveries.last
    email.to.should include(user.email)
    email.subject.should include(%(Deine E-Mail "Hello" wurde geöffnet))
    email.body.raw_source.should include(%(Diese E-Mail wurde bis jetzt 1 mal geöffnet))

    get "http://example.com/tracker/#{uuid}/tracker.gif", {}, { "HTTP_USER_AGENT" => "MYBrowser 1.0"}
    email = ActionMailer::Base.deliveries.last
    email.body.raw_source.should include(%(Diese E-Mail wurde bis jetzt 2 mal geöffnet))
    email.body.raw_source.should include("MYBrowser 1.0")
    email.body.raw_source.should include("127.0.0.1")
  end

  it "returns a 401 unauthorized with an invalid api_key" do
    post '/tracker', {
      recipient: 'email@example.com',
      subject: 'Hello',
      sender: user.email,
      api_key: 'unknown'
    }

    expect(response.status).to eq 401
  end
end