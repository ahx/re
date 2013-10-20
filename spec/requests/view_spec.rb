require 'spec_helper'

describe 'tracking' do
  let(:user) { create(:user) }

  before { ActionMailer::Base.deliveries.clear }

  it 'does not track the request if a notrack parameter is present' do
    post '/tracker', {
      recipient: 'email@example.com',
      subject: 'MySubject',
      api_key: user.api_key
    }

    tracker = Tracker.last
    uuid = tracker.message_token
    url = "http://www.example.com/tracker/#{uuid}/tracker.jpg?notrack=true"
    get url
    expect(response.status).to eq 200
    expect(View.where(tracker: tracker).count).to eq 0
  end

end
