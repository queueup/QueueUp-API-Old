require "rails_helper"

RSpec.describe CommunicationDataController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/communication_data").to route_to("communication_data#index")
    end


    # it "routes to #show" do
    #   expect(:get => "/communication_data/1").to route_to("communication_data#show", :id => "1")
    # end


    it "routes to #create" do
      expect(:post => "/communication_data").to route_to("communication_data#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/communication_data/1").to route_to("communication_data#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/communication_data/1").to route_to("communication_data#update", :id => "1")
    end

    # it "routes to #destroy" do
    #   expect(:delete => "/communication_data/1").to route_to("communication_data#destroy", :id => "1")
    # end

  end
end
