require 'rspec'
require 'rails_helper'

def authenticate_user
  @user = FactoryBot.create(:user)
  allow(controller).to receive(:authenticate_user!).and_return(true)
  allow(controller).to receive(:current_user).and_return(@user)
end

describe TasksController, :type => :controller do

  before do
    authenticate_user
  end

  describe "GET 'tasks'/'index'" do
    it ' should return HTTP status 200' do
      get :index, format: :json
      expect(response).to have_http_status (:success)
    end

    describe 'should return all tasks for current user: ' do
      it '0 tasks' do
        get :index, format: :json
        tasks = JSON.parse(response.body)
        expect(tasks.size).to eq(0)
      end
      it '1 list' do
        FactoryBot.create(:task, user_id: @user.id)
        get :index, format: :json
        tasks = JSON.parse(response.body)
        expect(tasks.size).to eq(1)
      end
    end
  end

  describe "POST 'tasks'/'new'" do
    it ' should return HTTP status 200' do
      post :new
      expect(response).to have_http_status (:success)
    end
  end


  describe "POST 'task'/'create'" do
    it ' should return HTTP status 200' do
      post :create, params: { task: { name: 'first', description: 'firstDes', user_id: @user.id }}, format: :json
      expect(response).to have_http_status (:success)
    end

    describe 'should create tasks: ' do
      it '1 task' do
        post :create, params: { task: { name: 'sdsdsd', description: 'sadasdasdas', user_id: @user.id }}, format: :json
        get :index, format: :json
        tasks = JSON.parse(response.body)
        expect(tasks.size).to eq(1)
      end
    end
  end


end