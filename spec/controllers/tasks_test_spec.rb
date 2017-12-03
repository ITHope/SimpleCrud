require 'rails_helper'
require "pg_tester"
require "tasks_controller"
require "request_spec_helper"
require 'devise'

RSpec.describe TasksController, :type=> :controller do
  describe "POST crud" do
    it "creates task" do
      allow(request.env['warden'])
          .to receive(:authenticate!)
                  .and_throw(:warden, {:scope => :user})
      post :create, params: { name:123, description:234}
      expect(response).to have_http_status (:found)
    end

    it "updates task" do
      allow(request.env['warden'])
          .to receive(:authenticate!)
                  .and_throw(:warden, {:scope => :user})
      post :edit, params: { name:123, description:789}
      expect(response).to have_http_status (:found)
    end

    it "delete task" do
      allow(request.env['warden'])
          .to receive(:authenticate!)
                  .and_throw(:warden, {:scope => :user})
      post :delete, params: { id:1 }
      expect(response).to have_http_status (:found)
    end
  end
end