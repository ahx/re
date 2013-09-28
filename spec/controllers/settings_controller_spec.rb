require 'spec_helper'

describe SettingsController do
  let(:user) { create(:user) }

  describe "#show" do
    it "requires authentication" do
      get :show
      response.should redirect_to root_path
      controller.login_browserid user.email
      get :show
      response.should be_success
    end
  end

end
