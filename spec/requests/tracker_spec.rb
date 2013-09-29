require 'spec_helper'

describe 'tracking' do
  let(:user) { create(:user) }

  before { ActionMailer::Base.deliveries.clear }

  it "returns a tracker HTML snippet and requesting it sends an email" do
    post '/tracker', {
      recipient: 'email@example.com',
      subject: 'MySubject',
      api_key: user.api_key
    }

    tracker = Tracker.last
    uuid = tracker.message_token
    tracker.user.should eq user # FIXME Move to controller spec

    url = "http://www.example.com/tracker/#{uuid}/tracker.jpg"
    expect(response.body).to include(%(<img src="#{url}" moz-do-not-send="true">))
    get url
    expect(response.status).to eq 200

    email = ActionMailer::Base.deliveries.last
    email.to.should include(user.email)
    email.subject.should include(%(Deine E-Mail "MySubject" wurde geöffnet))
    email.body.raw_source.should include(%(Diese E-Mail wurde bis jetzt 1 mal geöffnet))

    get "http://www.example.com/tracker/#{uuid}/tracker.jpg", {}, { "HTTP_USER_AGENT" => "MYBrowser 1.0"}
    email = ActionMailer::Base.deliveries.last
    email.body.raw_source.should include("MySubject")
    email.body.raw_source.should include("Diese E-Mail wurde bis jetzt 2 mal geöffnet")
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
