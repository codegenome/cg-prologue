run 'rm spec/controllers/admin/dashboard_controller_spec.rb'

create_file 'spec/controllers/admin/dashboard_controller_spec.rb' do
<<-'FILE'
  require 'spec_helper'
  include Devise::TestHelpers

  describe Admin::DashboardController do
    before(:each) do
      @user = @user ||=Factory.create(:admin)
      sign_in @user
    end

    describe "GET 'index'" do
      it "should be successful" do
        get 'index'
        response.should be_success
      end
    end

  end

FILE
end