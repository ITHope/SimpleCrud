require 'rails_helper'

RSpec.describe TasksController, :type=> :controller do
  describe "POST calculate" do
    it "calc minus" do
      post :calculate, params: { a:1, b:2, op:'-'}
      expect(response).to have_http_status (:ok)
    end
  end

  describe "calculate" do
    it "calc plus" do
      @calc = CalcController.new
      expect(@calc.instance_eval{ calc(1,2,'+')}).to eq 3
    end

    it "calc minus" do
      @calc = CalcController.new
      expect(@calc.instance_eval{ calc(1,2,'-')}).to eq -1
    end

    it "calc multiple" do
      @calc = CalcController.new
      expect(@calc.instance_eval{ calc(1,2,'*')}).to eq 2
    end

    it "calc div" do
      @calc = CalcController.new
      expect(@calc.instance_eval{ calc(4,2,'/')}).to eq 2
    end

    it "calc div" do
      @calc = CalcController.new
      expect(@calc.instance_eval{ calc(1.0,2,'/')}).to eq 0.5
    end
  end
end